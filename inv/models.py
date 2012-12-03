from django.db import models
from eve.models import Icon
from evemm.helpers import FormatWithCommas
from django.db.models.aggregates import Max, Min, Sum, Count
from django.db.models.loading import get_model
import datetime

class Type(models.Model):
	id = models.AutoField(primary_key=True, db_column="typeID");
	group = models.ForeignKey('Group', db_column="groupID");
	name = models.CharField(max_length=100, db_column="typeName", db_index=True);
	description = models.CharField(max_length=1000, db_column="description");
	mass = models.FloatField(db_column="mass");
	volume = models.FloatField(db_column="volume");
	capacity = models.FloatField(db_column="capacity");
	portionSize = models.IntegerField(db_column="portionSize");
	# race = models.ForeignKey(Race, db_column="raceID"); TODO
	basePrice = models.DecimalField(max_digits=19, decimal_places=4, db_column="basePrice");
	published = models.BooleanField(db_column="published");
	marketGroup = models.ForeignKey('MarketGroup', db_column="marketGroupID");
	chanceOfDuplicating = models.FloatField(db_column="chanceOfDuplicating");
	icon = models.ForeignKey(Icon, db_column="iconID");
	
	@property
	def formatted_basePrice(self):
		return FormatWithCommas('%.2f', self.basePrice) + " ISK";
	
	def bid(self, lthreshold = 0.20, uthreshold = 0.05):
		try:
			CurrPrice = get_model('market', 'CurrPrice')
			if(uthreshold == 0):
				return CurrPrice.objects.filter(type=self, bid=1).aggregate(Max('price'))['price__max'];
			else:
				num = CurrPrice.objects.filter(type=self, bid=1).count()
				return [CurrPrice.objects.filter(type=self, bid=1).order_by('price')[int(num*lthreshold)].price, \
						CurrPrice.objects.filter(type=self, bid=1).order_by('price')[int(num*(1-uthreshold))].price]
		except:
			return None
	
	def ask(self, lthreshold = 0.05, uthreshold = 0.20):
		try:
			CurrPrice = get_model('market', 'CurrPrice')
			if(lthreshold == 0):
				return CurrPrice.objects.filter(type=self, bid=0).aggregate(Min('price'))['price__min'];
			else:
				num = CurrPrice.objects.filter(type=self, bid=0).count()
				return [CurrPrice.objects.filter(type=self, bid=0).order_by('price')[int(num*lthreshold)].price, \
						CurrPrice.objects.filter(type=self, bid=0).order_by('price')[int(num*(1-uthreshold))].price]
		except:
			return None
	
	def marketinfo(self):
		try:
			CurrPrice = get_model('market', 'CurrPrice')
			num = CurrPrice.objects.filter(type=self).count()
			asks = CurrPrice.objects.filter(type=self, bid=0).order_by('price')
			bids = CurrPrice.objects.filter(type=self, bid=1).order_by('-price')
			
			return { "num" : num, "asks" : asks, "bids" : bids };
		except:
			return None
	
	def vol(self, date = None):
		try:
			MarketHistory = get_model('market', 'MarketHistory')
			if(date == None):
				last_day = MarketHistory.objects.filter(type=self, date__lt=datetime.date.today()).order_by('-date')[:1][0]
				volume = MarketHistory.objects.filter(type=self, date=last_day.date).aggregate(Sum('quantity'))['quantity__sum'];
				return volume;
			else:
				volume = MarketHistory.objects.filter(type=self, date=date).aggregate(Sum('quantity'))['quantity__sum'];
				return volume;
		except:
			return None
	
	def history(self, start, end = None):
		try:
			if(end == None):
				end = datetime.date.today();
			MarketHistory = get_model('market', 'MarketHistory')
			return MarketHistory.objects.raw("SELECT *, SUM(quantity) AS volume, SUM(quantity * average) AS trade_volume FROM market_markethistory WHERE type_id=%s AND date >= %s GROUP BY date", 
											[self.id, start.strftime("%Y-%m-%d")]);
		except:
			return None
	
	@property
	def volumetoday(self):
		try:
			return self.vol(datetime.date(datetime.datetime.utcnow().year, datetime.datetime.utcnow().month, datetime.datetime.utcnow().day));
		except:
			return None;
		
		
	def price(self, date = None):
		try:
			MarketHistory = get_model('market', 'MarketHistory')
			if(date == None) :
				last_day = MarketHistory.objects.filter(type=self).order_by('-date')[:1][0]
				records = MarketHistory.objects.raw("SELECT *, SUM(quantity) AS volume, SUM(quantity * average) AS trade_volume FROM market_markethistory WHERE type_id=%s AND date = %s GROUP BY date", 
								[self.id, last_day.date.strftime("%Y-%m-%d")]);
			else:
				records = MarketHistory.objects.raw("SELECT *, SUM(quantity) AS volume, SUM(quantity * average) AS trade_volume FROM market_markethistory WHERE type_id=%s AND date = %s GROUP BY date", 
								[self.id, date.strftime("%Y-%m-%d")]);
			
			if(len(list(records)) == 0):
				raise;
			
			
			return records[0].trade_volume / records[0].volume
		except:
			if(date == None) :
				try:
					return (self.ask(0.00, 0.05)[1] + self.bid(0.95, 1.00)[0]) / 2
				except:
					return None;
			else:
				return None
	
	class Meta:
		db_table = "invtypes";
	
	
class Group(models.Model):
	id = models.AutoField(primary_key=True, db_column="groupID");
	category = models.ForeignKey('Category', db_column="categoryID");
	name = models.CharField(max_length=100, db_column="groupName", db_index=True);
	description = models.CharField(max_length=3000, db_column="description");
	icon = models.ForeignKey(Icon, db_column="iconID");
	useBasePrice = models.BooleanField(db_column="useBasePrice");
	allowManufacture = models.BooleanField(db_column="allowManufacture");
	allowRecycler = models.BooleanField(db_column="allowRecycler");
	anchored = models.BooleanField(db_column="anchored");
	anchorable = models.BooleanField(db_column="anchorable");
	fittableNonSingleton = models.BooleanField(db_column="fittableNonSingleton");
	published = models.BooleanField(db_column="published");
	
	class Meta:
		db_table = "invgroups";
	
class MarketGroup(models.Model):
	id = models.AutoField(primary_key=True, db_column="marketGroupID");
	parentGroup = models.ForeignKey('MarketGroup', null=True, db_column="parentGroupID");
	name = models.CharField(max_length=100, db_column="marketGroupName");
	description = models.CharField(max_length=1000, db_column="description");
	icon = models.ForeignKey(Icon, db_column="iconID");
	hasTypes = models.BooleanField(db_column="hasTypes");
	
	class Meta:
		db_table = "marketgroups";
	
class Category(models.Model):
	id = models.AutoField(primary_key=True, db_column="categoryID");
	name = models.CharField(max_length=100, db_column="categoryName", db_index=True);
	description = models.CharField(max_length=3000, db_column="description");
	icon = models.ForeignKey(Icon, db_column="iconID");
	published = models.BooleanField(db_column="published");
	
	class Meta:
		db_table = "invcategories";