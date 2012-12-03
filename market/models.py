from django.db import models
from map.models import SolarSystem, Region
from sta.models import Station
from inv.models import Type
from django.db.models.fields import IntegerField

class BigIntegerField(IntegerField):
	empty_strings_allowed=False
	def get_internal_type(self):
		return "BigIntegerField"	
	def db_type(self):
		return 'bigint' # Note this won't work with Oracle.

class Order(models.Model):
	id = models.AutoField(primary_key = True);
	uid = models.BigIntegerField();
	price = models.DecimalField(max_digits=25, decimal_places=4);
	type = models.ForeignKey(Type)
	volRemaining = models.IntegerField();
	range = models.IntegerField();
	volEntered = models.IntegerField();
	minVolume = models.IntegerField();
	bid = models.BooleanField();
	issueDate = models.DateTimeField();
	duration = models.IntegerField();
	station = models.ForeignKey(Station);
	solarSystem = models.ForeignKey(SolarSystem);
	time = models.DateTimeField();
	
class CurrPrice(models.Model):
	order = models.ForeignKey(Order);
	type = models.ForeignKey(Type);
	station = models.ForeignKey(Station);
	bid = models.BooleanField();
	price = models.DecimalField(max_digits=25, decimal_places=4);
	
	class Meta:
		unique_together = ("type", "station", "bid");
		
class Information(models.Model):	#Stores approximate information for search purposes
	type = models.ForeignKey(Type);
	price = models.DecimalField(max_digits=25, decimal_places=4, null = True);
	volume = models.BigIntegerField(null = True);
	relevance = models.BigIntegerField(null = True);

class MarketHistory(models.Model):
	date = models.DateField();
	orders = models.IntegerField();
	low = models.DecimalField(max_digits=25, decimal_places=4);
	high = models.DecimalField(max_digits=25, decimal_places=4);
	average = models.DecimalField(max_digits=25, decimal_places=4);
	quantity = models.BigIntegerField();
	type = models.ForeignKey(Type);
	region = models.ForeignKey(Region);
	time = models.DateTimeField();
	
	@property
	def total(self):
		return self.quantity * self.average;
	
	class Meta:
		unique_together = ("date", "type", "region");