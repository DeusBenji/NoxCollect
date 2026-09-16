from sentence_transformers import SentenceTransformer
from PIL import Image
import io

MODEL_NAME = "clip-ViT-B-32"
EMBEDDING_DIM = 512
PREPROCESSING_VERSION = "v2-pad-square"

# Load the model globally (CPU only based on installation)
model = None

def warmup():
    global model
    if model is None:
        print(f"Loading vision model {MODEL_NAME}...")
        model = SentenceTransformer(MODEL_NAME)
        print("Model loaded. Performing warmup inference...")
        dummy_img = Image.new('RGB', (224, 224), color = 'white')
        model.encode(dummy_img)
        print("Warmup complete. Visual backend READY.")

def decode_image(image_bytes: bytes) -> Image.Image:
    """Decodes raw image bytes into an RGB PIL Image."""
    return Image.open(io.BytesIO(image_bytes)).convert("RGB")

def pad_to_square(img: Image.Image) -> Image.Image:
    """Pads a rectangular image to a square with black letterboxing."""
    width, height = img.size
    if width == height:
        return img
    
    max_dim = max(width, height)
    # Create a new square black image
    new_img = Image.new("RGB", (max_dim, max_dim), color=(0, 0, 0))
    # Paste the original image in the center
    paste_x = (max_dim - width) // 2
    paste_y = (max_dim - height) // 2
    new_img.paste(img, (paste_x, paste_y))
    return new_img

def get_embedding_from_image(img: Image.Image) -> list[float]:
    """Generates the CLIP embedding from a decoded PIL Image."""
    if model is None:
        warmup()
    # Pad to square to prevent destructive center-cropping by CLIP
    padded_img = pad_to_square(img)
    return model.encode(padded_img).tolist()

def get_image_embedding(image_bytes: bytes) -> list[float]:
    """Legacy helper."""
    img = decode_image(image_bytes)
    return get_embedding_from_image(img)
