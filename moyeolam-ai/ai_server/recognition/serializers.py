from rest_framework import serializers


class FaceDataSerializer(serializers.Serializer):
    result = serializers.BooleanField()
    confidence = serializers.FloatField()


class FaceRecognitionSerializer(serializers.Serializer):
    code = serializers.IntegerField()
    message = serializers.CharField(max_length=100)
    data = FaceDataSerializer()
