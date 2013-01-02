#encoding:utf-8
from django.forms import ModelForm
from django import forms
from captura.models import *

class MedicosNuevos(forms.ModelForm):
	"""docstring for MedicosNuevos"""
	class Meta:
		model = Tbl1Generales
		