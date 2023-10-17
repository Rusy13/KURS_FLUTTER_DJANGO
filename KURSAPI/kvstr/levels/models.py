from django.db import models

class Route(models.Model):
    name = models.CharField(max_length=100)

class Point(models.Model):
    route = models.ForeignKey(Route, on_delete=models.CASCADE)
    name = models.CharField(max_length=100, default="Default Name")
    latitude = models.FloatField()
    longitude = models.FloatField()
    description = models.TextField(blank=True, null=True)  # Добавляем поле 'description'
    hint = models.TextField(blank=True, null=True)  # Добавляем подсказки
    answer = models.TextField(blank=True, null=True) 