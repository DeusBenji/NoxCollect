import pytest
from fastapi.testclient import TestClient
from PIL import Image
import io

from api.main import app
from api.vision import get_image_embedding

client = TestClient(app)


class TestHealthEndpoint:
    def test_health_check(self):
        response = client.get("/health")
        assert response.status_code == 200
        data = response.json()
        assert "status" in data
        assert "model" in data


class TestRecognizeEndpoint:
    def test_recognize_success(self):
        # Create a dummy 1x1 image
        img = Image.new('RGB', (1, 1), color='white')
        img_byte_arr = io.BytesIO()
        img.save(img_byte_arr, format='PNG')
        img_bytes = img_byte_arr.getvalue()
        
        files = {"file": ("dummy.png", img_bytes, "image/png")}
        data = {
            "ocr_name": "charizard",
            "ocr_number": "4"
        }
        response = client.post("/recognize", files=files, data=data)
        assert response.status_code == 200
        res_data = response.json()
        assert res_data["status"] == "success"
        assert "candidates" in res_data
        
    def test_recognize_no_ocr(self):
        img = Image.new('RGB', (1, 1), color='white')
        img_byte_arr = io.BytesIO()
        img.save(img_byte_arr, format='PNG')
        img_bytes = img_byte_arr.getvalue()
        
        files = {"file": ("dummy.png", img_bytes, "image/png")}
        response = client.post("/recognize", files=files)
        assert response.status_code == 200
        res_data = response.json()
        assert res_data["status"] == "success"
        assert "candidates" in res_data


class TestSearchEndpoint:
    def test_search_success(self):
        response = client.get("/search?q=charizard")
        assert response.status_code == 200
        data = response.json()
        assert "results" in data
        assert isinstance(data["results"], list)

    def test_search_pagination(self):
        response1 = client.get("/search?q=charizard&skip=0&limit=1")
        assert response1.status_code == 200
        data1 = response1.json()
        
        response2 = client.get("/search?q=charizard&skip=1&limit=1")
        assert response2.status_code == 200
        data2 = response2.json()

        if data1["results"] and data2["results"]:
            assert data1["results"] != data2["results"]

    def test_search_no_matches(self):
        response = client.get("/search?q=thisisnotarealcardname12345")
        assert response.status_code == 200
        data = response.json()
        assert data["results"] == []

    def test_search_empty_query(self):
        response = client.get("/search?q=")
        assert response.status_code == 200
        data = response.json()
        assert data["results"] == []

    def test_search_sort_default(self):
        response = client.get("/search?q=charizard&sort_by=default")
        assert response.status_code == 200
        data = response.json()
        assert "results" in data
        assert isinstance(data["results"], list)

    def test_search_sort_number_asc(self):
        response = client.get("/search?q=charizard&sort_by=number_asc")
        assert response.status_code == 200
        data = response.json()
        assert "results" in data
        assert isinstance(data["results"], list)
        results = data["results"]
        if len(results) >= 2:
            def card_num_key(res):
                num_str = str(res.get("cardNumber", "")).strip()
                return num_str.zfill(5)
            for i in range(len(results) - 1):
                assert card_num_key(results[i]) <= card_num_key(results[i + 1])

    def test_search_sort_name_asc(self):
        response = client.get("/search?q=charizard&sort_by=name_asc")
        assert response.status_code == 200
        data = response.json()
        assert "results" in data
        assert isinstance(data["results"], list)
        results = data["results"]
        if len(results) >= 2:
            for i in range(len(results) - 1):
                assert results[i]["name"] <= results[i + 1]["name"]

    def test_search_sort_number_desc(self):
        response = client.get("/search?q=base1&sort_by=number_desc")
        assert response.status_code == 200
        data = response.json()
        assert "results" in data
        assert isinstance(data["results"], list)
        results = data["results"]
        if len(results) >= 2:
            def card_num_key(res):
                num_str = str(res.get("cardNumber", "")).strip()
                return int(num_str) if num_str.isdigit() else 0
            for i in range(len(results) - 1):
                assert card_num_key(results[i]) >= card_num_key(results[i + 1])

    def test_search_mode_set(self):
        # In 'all' mode, searching 'DRI' returns card names containing 'dri' (e.g. Drifloon, Beedrill, Dodrio)
        response_all = client.get("/search?q=DRI&search_mode=all")
        assert response_all.status_code == 200
        cards_all = response_all.json()["results"]
        assert any("drif" in c["name"].lower() or "drill" in c["name"].lower() for c in cards_all)

        # In 'set' mode, searching 'DRI' returns only cards from Destined Rivals (set id sv10), excluding Drifloon/Beedrill
        response_set = client.get("/search?q=DRI&search_mode=set")
        assert response_set.status_code == 200
        cards_set = response_set.json()["results"]
        assert len(cards_set) > 0
        assert not any("drif" in c["name"].lower() or "drill" in c["name"].lower() for c in cards_set)
        for card in cards_set:
            assert card["setId"] == "sv10" or card.get("setCode") == "DRI"


class TestVisionPipeline:
    def test_get_image_embedding(self):
        # Create a dummy 1x1 image
        img = Image.new('RGB', (1, 1), color='white')
        img_byte_arr = io.BytesIO()
        img.save(img_byte_arr, format='PNG')
        img_bytes = img_byte_arr.getvalue()
        
        embedding = get_image_embedding(img_bytes)
        
        assert embedding is not None
        assert isinstance(embedding, list)
        assert len(embedding) == 512
