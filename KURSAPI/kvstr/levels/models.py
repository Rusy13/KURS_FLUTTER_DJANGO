from django.db import models

class Route(models.Model):
    name = models.CharField(max_length=100)

class Point(models.Model):
    route = models.ForeignKey(Route, on_delete=models.CASCADE)
    name = models.CharField(max_length=100, default="Default Name")  # значение по умолчанию
    latitude = models.FloatField()
    longitude = models.FloatField()