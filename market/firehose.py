"""
Example Python EMDR client.
"""
import zlib
import zmq
# You can substitute the stdlib's json module, if that suits your fancy
import simplejson
from inv.models import Type
from market.models import CurrPrice, Order, MarketHistory
from map.models import SolarSystem, Region
from sta.models import Station
import datetime
from django.utils import timezone

def main():
	context = zmq.Context()
	subscriber = context.socket(zmq.SUB)

	# Connect to the first publicly available relay.
	subscriber.connect('tcp://relay-us-central-1.eve-emdr.com:8050')
	# Disable filtering.
	subscriber.setsockopt(zmq.SUBSCRIBE, "")

	while True:
		# Receive raw market JSON strings.
		market_json = zlib.decompress(subscriber.recv())
		# Un-serialize the JSON data to a Python dict.
		market_data = simplejson.loads(market_json)
		# Dump the market data to stdout. Or, you know, do more fun
		# things here.
		if(market_data["resultType"] == "history"):
			for j in market_data["rowsets"]:
				region = Region.objects.get(id=j['regionID']);
				for i in j['rows']:
					type = Type.objects.get(id=j['typeID']);
					date = datetime.datetime.date(datetime.datetime.strptime(i[0][:-6], "%Y-%m-%dT%H:%M:%S").replace(tzinfo=timezone.utc));
					print "HIS " + type.name + " (" + str(j['typeID']) + ")"\
								": "+ str(date) + " | " + str(i[1]) + " ORD / LOW " + str(i[2]) + " HIGH " + str(i[3]) + " AVG " + str(i[4]) + " VOL " + str(i[5]);
					
					
					
					try:
						old_hist = MarketHistory.objects.get(date = date, type = type, region = region)
						td = old_hist.time.replace(tzinfo=timezone.utc) - datetime.datetime.utcnow().replace(tzinfo=timezone.utc)
						if(td.days <= 1) :
							old_hist.orders = i[1]
							old_hist.low = i[3]
							old_hist.high = i[4]
							old_hist.average = i[5]
							old_hist.quantity = i[2]
							if(old_hist.average < old_hist.low or old_hist.high < old_hist.average or old_hist.low > old_hist.high):
								continue;
							old_hist.save()
					except:
						hist = MarketHistory()
						hist.region = region
						hist.type = type
						hist.date = date
						hist.orders = i[1]
						hist.low = i[3]
						hist.high = i[4]
						hist.average = i[5]
						if(hist.average < hist.low or hist.high < hist.average or hist.low > hist.high):
							continue;
						hist.quantity = i[2]
						hist.time = datetime.datetime.now().replace(tzinfo=timezone.utc);
						hist.save()
					
					
		else:
			for j in market_data["rowsets"]:
				for i in j['rows']:
					if(i[6] == 0):
						action = "ASK";
					else:
						action = "BID"
					
					try:
						print "ORD " + Type.objects.get(id=j['typeID']).name + " (" + str(j['typeID']) + ")"\
									": "+ str(i[0]) + " ISK | VOL " + str(i[1]) + "/" + str(i[4]) + " " + action + " STN " + str(i[9]);
						
						order = Order();
						order.price = i[0];
						order.uid = i[3];
						order.type = Type.objects.get(id=j['typeID']);
						order.station = Station.objects.get(id=i[9]);
						order.solarSystem = SolarSystem.objects.get(id=i[10]);
						order.type = Type.objects.get(id=j['typeID']);
						order.bid = i[6];
						order.volEntered = i[4];
						order.volRemaining = i[1];
						order.range = i[2]
						order.issueDate = datetime.datetime.strptime(i[7][:-6], "%Y-%m-%dT%H:%M:%S").replace(tzinfo=timezone.utc);
						order.minVolume = i[5];
						order.duration = i[8];
						order.time = datetime.datetime.utcnow().replace(tzinfo=timezone.utc);
						order.save();
						
						try:
							old_price = CurrPrice.objects.get(type=j['typeID'], station=i[9], bid=i[6]);
							td = old_price.order.time.replace(tzinfo=timezone.utc) - datetime.datetime.utcnow().replace(tzinfo=timezone.utc);
							if (([0] < old_price) and i[6] == False) or (([0] > old_price) and i[6] == True) or (td.seconds > 2):
								old_price.price = i[0];
								old_price.order = order;
								old_price.save();
						except:
							price = CurrPrice();
							price.order = order;
							price.price = i[0];
							price.station = Station.objects.get(id=i[9]);
							price.type = Type.objects.get(id=j['typeID']);
							price.bid=i[6];
							price.save();
					except:
						pass;
			
if __name__ == '__main__':
	main()