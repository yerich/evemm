from inv.models import Type
import datetime
from market.models import Information
import math


def main():
	types = Type.objects.filter(published=1);
	
	for i in types:
		try:
			Information.objects.get(type=i).delete();
		except:
			pass;
		print i.name;
		
		info = Information();
		info.type = i;
		info.save()
		try:
			info.volume = i.vol(datetime.date(2012, 10, 25));
		except:
			pass;
		
		try:
			
			count = 0;
			priceavg = 0;
			for j in range(1, 14):
				try:
					priceavg += i.price(datetime.date(2012, 10, j))
					count += 1;
				except:
					pass;
			
			if(count == 0):
				info.price = i.price();
			else:
				info.price = priceavg/count
		except:
			pass;
		
		try:
			info.relevance = int(info.volume * float(info.price))
		except:
			pass;
	
		info.save()
		
	
if __name__ == '__main__':
	main()