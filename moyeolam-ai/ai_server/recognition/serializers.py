from rest_framework import serializers


class FaceRecognitionSerializer(serializers.Serializer):
    code = serializers.IntegerField()
    message = serializers.CharField(max_length=100)
    data = serializers.BooleanField()
