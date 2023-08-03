from django.urls import path
from recognition import views

urlpatterns = [
    path('face/', views.face),
]
