from rest_framework.decorators import api_view
from rest_framework.response import Response
from .serializers import FaceRecognitionSerializer


@api_view(['GET'])
def face(request):
    image_file = request.FILES["image"]

    if image_file is not None:
        with open('uploaded_image.png', 'wb') as f:
            for chunk in image_file.chunks():
                f.write(chunk)

    response = FaceRecognitionSerializer(data={
        "code": 200,
        "message": "success",
        "data": True
    })

    if response.is_valid():
        return Response(response.data)


    error_response = FaceRecognitionSerializer(data={
        "code": 400,
        "message": "얼굴 인식 처리 도중 오류가 발생",
        "data": False
    })
    return Response(error_response.data)
