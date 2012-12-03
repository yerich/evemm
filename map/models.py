from django.db import models
		
class Region(models.Model):
	id = models.AutoField(primary_key=True, db_column="regionID");
	name = models.CharField(max_length=100, db_column="regionName");
	
	class Meta:
		db_table = "mapregions";
		
class Constellation(models.Model):
	id = models.AutoField(primary_key=True, db_column="constellationID");
	name = models.CharField(max_length=100, db_column="constellationName");
	region = models.ForeignKey(Region, db_column="regionID");
	
	class Meta:
		db_table = "mapconstellations";
		
class SolarSystem(models.Model):
	id = models.AutoField(primary_key=True, db_column="solarSystemID");
	name = models.CharField(max_length=100, db_column="solarSystemName");
	constellation = models.ForeignKey(Constellation, db_column="constellationID");
	region = models.ForeignKey(Region, db_column="regionID");
	security = models.FloatField(db_column="security");
	
	def securityLevel(self):
		return max(0, self.security);
	
	class Meta:
		db_table = "mapsolarsystems";