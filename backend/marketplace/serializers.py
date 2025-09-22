from rest_framework import serializers
from django.contrib.auth.models import User
from .models import Farmer, Product, Order

class FarmerSerializer(serializers.ModelSerializer):
    """
    Serializer for the Farmer model.
    """
    class Meta:
        model = Farmer
        fields = '__all__'

class ProductSerializer(serializers.ModelSerializer):
    """
    Improved serializer for the Product model.
    The 'user' field is read-only and shows the username.
    """
    user = serializers.StringRelatedField(read_only=True)

    class Meta:
        model = Product
        fields = '__all__'
        read_only_fields = ['created_at', 'user']

class OrderSerializer(serializers.ModelSerializer):
    """
    Serializer for the Order model that handles both reading and writing.
    It displays the product's full details on GET, but accepts a product ID on POST.
    """
    user = serializers.StringRelatedField(read_only=True)
    
    # This field will show the product's full details on GET requests.
    product_details = ProductSerializer(source='product', read_only=True)
    
    # This field will accept a product ID on POST requests.
    product = serializers.PrimaryKeyRelatedField(queryset=Product.objects.all(), write_only=True)

    class Meta:
        model = Order
        fields = ['id', 'user', 'product', 'product_details', 'created_at', 'status']
        read_only_fields = ['created_at', 'user']
        
    def create(self, validated_data):
        return Order.objects.create(**validated_data)

class UserSerializer(serializers.ModelSerializer):
    """
    Serializer for the User model, used for registration.
    """
    class Meta:
        model = User
        fields = ['username', 'email', 'password']
        extra_kwargs = {'password': {'write_only': True}}
    
    def create(self, validated_data):
        user = User.objects.create_user(
            username=validated_data['username'],
            email=validated_data.get('email', ''),
            password=validated_data['password']
        )
        return user