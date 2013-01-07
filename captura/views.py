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
from django.db.models import Q
from django.views.decorators.csrf import csrf_exempt
#from django.views.decorators.csrf import csrf_protect

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

@csrf_exempt
def Login(request):
	template = 'prueba.html' #nombre de la plantilla
	u = request.POST['usuario']
	p = request.POST['password']
	cedula = Permisos.objects.all().filter(usuario=u,clave=p)
	elementos = Tbl1Generales.objects.all().filter(cedula=cedula)
	if len(elementos) > 0:
		lista = {'lista':elementos} #Asignar resultados a la lista para 'render_to_response'
		return render_to_response(template,lista)#Enviar parametros al 'render_to_response'
	else:
		return HttpResponseRedirect('/')

def FormLogin(request):
	template = 'login.html' #nombre de la plantilla
	return render_to_response(template)