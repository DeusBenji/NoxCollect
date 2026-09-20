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
