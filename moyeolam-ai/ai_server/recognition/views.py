from rest_framework.decorators import api_view
from rest_framework.response import Response
from .serializers import FaceRecognitionSerializer

import mediapipe as mp
import cv2
from PIL import Image
import numpy as np

mp_face_detection = mp.solutions.face_detection

CONFIDENCE_THRESHOLD = 0.8


@api_view(['GET'])
def face(request):
    try:
        image_file = Image.open(request.FILES['image'])
        image_file = cv2.cvtColor(np.array(image_file), cv2.COLOR_RGB2BGR)

        confidence = 0
        recognition_result = False
        with mp_face_detection.FaceDetection(
                model_selection=1, min_detection_confidence=0.9) as face_detection:

            image_file = cv2.cvtColor(image_file, cv2.COLOR_BGR2RGB)
            results = face_detection.process(image_file)

            if results.detections:
                for detection in results.detections:
                    confidence = max(confidence, detection.score[0])

        if confidence >= CONFIDENCE_THRESHOLD:
            recognition_result = True

        response = FaceRecognitionSerializer(data={
            "code": 200,
            "message": "success",
            "data": {
                "result": recognition_result,
                "confidence": confidence * 100
            }
        })

        if response.is_valid():
            return Response(response.data)
        else:
            return Response({
                "code": 400,
                "message": response.errors,
                "data": {
                    "result": False,
                    "confidence": 0
                }
            }, status=400)
    except:
        return Response({
            "code": 400,
            "message": "얼굴 인식에 오류가 발생했습니다.",
            "data": {
                "result": False,
                "confidence": 0
            }
        }, status=400)
