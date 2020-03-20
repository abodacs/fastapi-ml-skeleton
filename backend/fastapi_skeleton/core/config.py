from typing import List

from starlette.config import Config
from starlette.datastructures import CommaSeparatedStrings, Secret

APP_VERSION = "0.0.1"
APP_NAME = "House Price Prediction Example"
API_PREFIX = "/api"

config = Config(".env")

API_KEY: Secret = config("API_KEY", cast=Secret)
IS_DEBUG: bool = config("IS_DEBUG", cast=bool, default=False)
ALLOWED_HOSTS: List[str] = config(
    "ALLOWED_HOSTS", cast=CommaSeparatedStrings, default=""
)

DEFAULT_MODEL_PATH: str = config("DEFAULT_MODEL_PATH")
