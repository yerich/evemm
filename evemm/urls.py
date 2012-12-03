from django.conf.urls import patterns, include, url
from django.contrib import admin
from django.views.generic.simple import redirect_to
admin.autodiscover()

urlpatterns = patterns('',
					url(r'^$', 'evemm.views.main'),
					url(r'^get/inv/(.+)$', 'inv.views.find'),
					url(r'^get/inv/$', 'inv.views.main'),
					url(r'^get/(.+)$', 'evemm.views.get'),
    # Examples:
    # url(r'^$', 'evemm.views.home', name='home'),
    # url(r'^evemm/', include('evemm.foo.urls')),

    # Uncomment the admin/doc line below to enable admin documentation:
    # url(r'^admin/doc/', include('django.contrib.admindocs.urls')),

    # Uncomment the next line to enable the admin:
    # url(r'^admin/', include(admin.site.urls)),
)
