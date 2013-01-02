# Create your views here.

#Importar modelos de la aplicacion
from captura.models import *
from captura.forms import *

#Modulos de Django
from django.contrib.humanize.templatetags.humanize import *
from django.utils.numberformat import *
from django.shortcuts import render_to_response
from django.http import HttpResponse,HttpResponseRedirect
from django.db.models import Count
from django.template.context import RequestContext

#def listas(request):
    #template = 'prueba.html' #nombre de la plantilla
    #also = QryMantto1.objects.values('n_also').annotate(Total=Count('n_also'))
    #fecha = QryMantto1.objects.values('fecha_captura').annotate(Total=Count('fecha_captura'))
    #lista = {'alsos':also,'fechas':fecha} #Asignar resultados a la lista para 'render_to_response'
    #return render_to_response(template,lista)#Enviar parametros al 'render_to_response'

def Medicos(request):
	if request.method == 'POST':
		form = MedicosNuevos(request.POST) 
		if form.is_valid():
			form.save()
			return HttpResponseRedirect('/')
	else:
		form = MedicosNuevos()

	#Enviar parametros al 'render_to_response'
	return render_to_response('medicos.html', context_instance=RequestContext(request,{'form': form}))