from django.db import models

class Icon(models.Model):
	id = models.AutoField(primary_key=True, db_column="iconID");
	file = models.CharField(max_length=500, db_column="iconFile", db_index=True);
	description = models.CharField(max_length=3000, db_column="description");
	
	class Meta:
		db_table = "eveicons";