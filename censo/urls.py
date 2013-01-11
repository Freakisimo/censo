from django.conf.urls import patterns, include, url

# Uncomment the next two lines to enable the admin:
from django.contrib import admin
admin.autodiscover()

# Esta url es para Dajaxice
# from dajaxice.core import dajaxice_autodiscover, dajaxice_config
# dajaxice_autodiscover()

from django.contrib.staticfiles.urls import staticfiles_urlpatterns

urlpatterns = patterns('',
    # Examples:
    # url(r'^$', 'censo.views.home', name='home'),
    # url(r'^censo/', include('censo.foo.urls')),

    url(r'^nuevo_medico/', 'captura.views.Medicos'),
    url(r'^$', 'captura.views.FormLogin'),
    url(r'^login', 'captura.views.Login'),
    url(r'^perfil', 'captura.views.Perfil'),

    # URL para dajaxice
    # url(dajaxice_config.dajaxice_url, include('dajaxice.urls')),

    # Uncomment the admin/doc line below to enable admin documentation:
	url(r'^admin/doc/', include('django.contrib.admindocs.urls')),

    # Uncomment the next line to enable the admin:
	url(r'^admin/', include(admin.site.urls)),
)

urlpatterns += staticfiles_urlpatterns()