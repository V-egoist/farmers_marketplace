# your_app_name/urls.py

from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import FarmerList, ProductList, register_user, login_user, OrderViewSet

# Create a router and register our viewsets with it.
router = DefaultRouter()
router.register(r'orders', OrderViewSet, basename='order')

urlpatterns = [
    path('farmers/', FarmerList.as_view(), name='farmer-list'),
    path('products/', ProductList.as_view(), name='product-list'),
    
    # User authentication URLs
    path('register/', register_user, name='register'),
    path('login/', login_user, name='login'),
    
    # Use the router to generate URLs for the ViewSet
    path('', include(router.urls)),
]