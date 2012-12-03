# Create your views here.
from django.shortcuts import render_to_response
from inv.models import Type
import datetime
from evemm.helpers import FormatWithCommas
from market.models import Information

def main(request):
	return render_to_response("inv/main.html", {});

def get(request, item):
	price_color = '#EEE;'
	try:
		price_yesterday = item.price(date = datetime.date(datetime.datetime.utcnow().year, datetime.datetime.utcnow().month, datetime.datetime.utcnow().day) - datetime.timedelta(1));
		price_today = item.price();
		if(price_today and price_yesterday):
			price_change = price_today - price_yesterday
		
		
		if(price_change < 0):
			price_color = '#900000';
		elif(price_change > 0):
			price_color = '#009000';
		else:
			price_change = 0;
	except:
		price_today = item.price();
		price_yesterday =  None
		price_change = 0
	
	try:
		marketinfo = item.marketinfo();
		lowest_price = marketinfo['asks'][0];
		highest_price = marketinfo['bids'][0];
	except:
		lowest_price = 0;
		highest_price = 0;
	
	history_raw = item.history(datetime.date.today() - datetime.timedelta(31));
	history = [];
	for i in list(history_raw):
		history.append({ "date" : i.date, "volume" : i.volume, "trade_volume" : i.trade_volume, "average" : i.trade_volume / i.volume });
	
	return render_to_response("inv/type.html", \
							{"type" : item, "price_today" : price_today, \
							"price_yesterday" : price_yesterday, "price_color" : price_color,
							"price_change" : price_change, "lowest_price" : lowest_price, "highest_price" : highest_price,
							"history" : history})

def find(request, query):
	item = None;
	try:
		item = Type.objects.get(id=query, published=True);
	except:
		pass
	
	if (item == None):
		try:
			item = Type.objects.get(name=query, published=True);
		except:
			pass
	
	if (item != None):
		return get(request, item);
	
	matches = Information.objects.filter(type__name__istartswith=query, type__published=1).order_by("-relevance")[:100];
	
	return render_to_response("inv/find.html", {"query" : query, "matches" : matches});