import pytest

from starlette.config import environ
from starlette.testclient import TestClient

# Skeleton
from fastapi_skeleton.main import app  # noqa: E402


environ["API_KEY"] = "a1279d26-63ac-41f1-8266-4ef3702ad7cb"
environ["DEFAULT_MODEL_PATH"] = "./sample_model/lin_reg_california_housing_model.joblib"


@pytest.fixture(scope="module")
def test_client():
    with TestClient(app) as client:
        yield client
