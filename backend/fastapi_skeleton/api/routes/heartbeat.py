from fastapi import APIRouter

# Skeleton
from fastapi_skeleton.models.heartbeat import HeartbeatResult

router = APIRouter()


@router.get("/heartbeat", response_model=HeartbeatResult, name="heartbeat")
def get_hearbeat() -> HeartbeatResult:
    return HeartbeatResult(is_alive=True)
