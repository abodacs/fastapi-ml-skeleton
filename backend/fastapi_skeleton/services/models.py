# Standard Library
from pathlib import Path
from typing import List, Optional, Union

import joblib  # type: ignore
import numpy as np  # type: ignore
from loguru import logger

# Skeleton
from fastapi_skeleton.core.messages import NO_VALID_PAYLOAD
from fastapi_skeleton.models.payload import HousePredictionPayload, payload_to_list
from fastapi_skeleton.models.prediction import HousePredictionResult


class HousePriceModel:  # noqa: WPS338
    RESULT_UNIT_FACTOR = 100000  # noqa: WPS115

    def __init__(self, path: Union[str, Path]) -> None:
        self.path = path
        self._load_local_model()

    def _load_local_model(self) -> None:
        self.model = joblib.load(self.path)

    def _pre_process(self, payload: HousePredictionPayload) -> List[float]:
        logger.debug("Pre-processing payload.")
        return np.asarray(payload_to_list(payload)).reshape(1, -1)

    def _post_process(self, prediction: np.ndarray) -> HousePredictionResult:
        logger.debug("Post-processing prediction.")
        prediction_result = prediction.tolist()
        human_readable_unit = prediction_result[0] * self.RESULT_UNIT_FACTOR
        return HousePredictionResult(median_house_value=human_readable_unit)

    def _predict(self, features: np.ndarray) -> np.ndarray:
        logger.debug("Predicting.")
        return self.model.predict(features)

    def predict(
        self, payload: Optional[HousePredictionPayload]
    ) -> HousePredictionResult:
        if payload is None:
            raise ValueError(NO_VALID_PAYLOAD.format(payload))

        pre_processed_payload = self._pre_process(payload)
        prediction = self._predict(pre_processed_payload)
        logger.info(prediction)

        return self._post_process(prediction)
