# Generated by Django 4.2.6 on 2023-10-11 10:45

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('levels', '0002_route_delete_level_point_route'),
    ]

    operations = [
        migrations.AlterField(
            model_name='point',
            name='route',
            field=models.ForeignKey(default=1, on_delete=django.db.models.deletion.CASCADE, to='levels.route'),
        ),
    ]
