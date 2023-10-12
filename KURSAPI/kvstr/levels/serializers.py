from rest_framework import serializers
from .models import Route, Point

class RouteSerializer(serializers.ModelSerializer):
    class Meta:
        model = Route
        fields = '__all__'

class PointSerializer(serializers.ModelSerializer):
    class Meta:
        model = Point
        fields = '__all__'
