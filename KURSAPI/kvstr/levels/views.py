from rest_framework import generics
from .models import Route, Point
from .serializers import RouteSerializer, PointSerializer

class RouteListCreateView(generics.ListCreateAPIView):
    queryset = Route.objects.all()
    serializer_class = RouteSerializer

class PointListCreateView(generics.ListCreateAPIView):
    serializer_class = PointSerializer

    def get_queryset(self):
        route_id = self.kwargs.get('route_id')
        return Point.objects.filter(route__id=route_id)

class PointListView(generics.ListAPIView):
    serializer_class = PointSerializer

    def get_queryset(self):
        route_id = self.kwargs.get('route_id')
        return Point.objects.filter(route__id=route_id)
