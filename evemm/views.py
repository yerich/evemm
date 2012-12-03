from django.shortcuts import render_to_response
from django.template.context import RequestContext
from inv.models import Type
from django.http import Http404
from market.models import Order
from map.models import SolarSystem
from django.db.models.loading import get_model
import datetime

def main(request):
	MarketHistory = get_model('market', 'MarketHistory')
	last_day = MarketHistory.objects.filter(type=34, date__lt=datetime.date.today()).order_by('-date')[:1][0]
	records = MarketHistory.objects.filter(type=34, date=last_day.date)
	records.count
	
	wh=0;
	for i in records:
		wh += i.total;
	return render_to_response("main.html", {}, context_instance=RequestContext(request));

def get(request, q):	# This function interprets undefined commands (i.e. shortcuts)
	return render_to_response("main.html", {"object" : q}, context_instance=RequestContext(request));