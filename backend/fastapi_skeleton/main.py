from fastapi import FastAPI
from fastapi.exceptions import RequestValidationError
from starlette.exceptions import HTTPException
from starlette.middleware.cors import CORSMiddleware
from fastapi_skeleton.core.event_handlers import start_app_handler, stop_app_handler

from fastapi_skeleton.api.errors.http_error import http_error_handler
from fastapi_skeleton.api.errors.validation_error import http422_error_handler
from fastapi_skeleton.api.routes.router import api_router
from fastapi_skeleton.core.config import (
    ALLOWED_HOSTS,
    API_PREFIX,
    APP_NAME,
    APP_VERSION,
    IS_DEBUG,
)


def get_app() -> FastAPI:
    fast_app = FastAPI(title=APP_NAME, version=APP_VERSION, debug=IS_DEBUG)
    fast_app.add_middleware(
        CORSMiddleware,
        allow_origins=ALLOWED_HOSTS or ["*"],
        allow_credentials=True,
        allow_methods=["*"],
        allow_headers=["*"],
    )

    fast_app.add_event_handler("startup", start_app_handler(fast_app))
    fast_app.add_event_handler("shutdown", stop_app_handler(fast_app))

    fast_app.add_exception_handler(HTTPException, http_error_handler)
    fast_app.add_exception_handler(RequestValidationError, http422_error_handler)

    fast_app.include_router(api_router, prefix=API_PREFIX)

    return fast_app


app = get_app()
