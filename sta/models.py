from django.db import models
from map.models import SolarSystem, Region, Constellation

class Station(models.Model):
	id = models.AutoField(primary_key=True, db_column="stationID");
	solarSystem = models.ForeignKey(SolarSystem, db_column="solarSystemID");
	constellation = models.ForeignKey(Constellation, db_column="constellationID");
	region = models.ForeignKey(Region, db_column="regionID");
	name = models.CharField(max_length=100, db_column="stationName");
	
	class Meta:
		db_table = "stastations";