from django.urls import path
from .views import RouteListCreateView, PointListCreateView, PointListView

urlpatterns = [
    path('routes/', RouteListCreateView.as_view(), name='route-list-create'),
    path('routes/<int:route_id>/points/', PointListCreateView.as_view(), name='point-list-create'),
    path('routes/<int:route_id>/points/list/', PointListView.as_view(), name='point-list'),
]
