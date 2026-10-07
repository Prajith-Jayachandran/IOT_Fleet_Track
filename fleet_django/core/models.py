from django.db import models

class Vehicle(models.Model):
    registration_no = models.CharField(max_length=20, unique=True)
    vehicle_type = models.CharField(max_length=50)
    model = models.CharField(max_length=100)
    manufacturer = models.CharField(max_length=100)
    status = models.CharField(max_length=20, default='ACTIVE')
    fuel_capacity = models.DecimalField(max_digits=6, decimal_places=2)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = 'vehicles'

class Driver(models.Model):
    license_number = models.CharField(max_length=50, unique=True)
    first_name = models.CharField(max_length=50)
    last_name = models.CharField(max_length=50)
    status = models.CharField(max_length=20, default='AVAILABLE')
    phone = models.CharField(max_length=20)
    hire_date = models.DateField()

    class Meta:
        db_table = 'drivers'

class Trip(models.Model):
    vehicle = models.ForeignKey(Vehicle, on_delete=models.CASCADE)
    driver = models.ForeignKey(Driver, on_delete=models.CASCADE)
    start_time = models.DateTimeField()
    end_time = models.DateTimeField(null=True, blank=True)
    status = models.CharField(max_length=20, default='IN_PROGRESS')
    start_location = models.CharField(max_length=255)
    end_location = models.CharField(max_length=255)
    distance_km = models.DecimalField(max_digits=8, decimal_places=2, null=True)

    class Meta:
        db_table = 'trips'

class Telemetry(models.Model):
    vehicle = models.ForeignKey(Vehicle, on_delete=models.CASCADE)
    timestamp = models.DateTimeField(auto_now_add=True)
    latitude = models.DecimalField(max_digits=10, decimal_places=8)
    longitude = models.DecimalField(max_digits=11, decimal_places=8)
    speed = models.DecimalField(max_digits=5, decimal_places=2)
    fuel_level = models.DecimalField(max_digits=5, decimal_places=2)

    class Meta:
        db_table = 'gps_locations'

class Maintenance(models.Model):
    vehicle = models.ForeignKey(Vehicle, on_delete=models.CASCADE)
    service_date = models.DateField(auto_now_add=True)
    description = models.CharField(max_length=255)
    cost = models.DecimalField(max_digits=8, decimal_places=2)
    status = models.CharField(max_length=20, default='COMPLETED')

    class Meta:
        db_table = 'maintenance'
