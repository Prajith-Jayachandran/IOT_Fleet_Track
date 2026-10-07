import random
from django.core.management.base import BaseCommand
from core.models import Vehicle, Driver, Trip, Telemetry

class Command(BaseCommand):
    help = 'Seeds the database with full mock data for all tables'

    def handle(self, *args, **kwargs):
        self.stdout.write(self.style.SUCCESS('Seeding database...'))
        
        # Seed Drivers
        if Driver.objects.count() == 0:
            for i in range(10):
                Driver.objects.create(
                    license_number=f"DL{random.randint(10000, 99999)}",
                    first_name=random.choice(["Arun", "Bala", "Karthik", "Suresh", "Ramesh", "Vijay"]),
                    last_name=random.choice(["Kumar", "Raj", "Prakash", "Natarajan"]),
                    phone=f"98{random.randint(10000000, 99999999)}",
                    hire_date="2023-01-15"
                )
            self.stdout.write('Drivers seeded!')

        # Seed Vehicles
        if Vehicle.objects.count() == 0:
            for i in range(15):
                Vehicle.objects.create(
                    registration_no=f"TN{random.randint(10, 99)}AB{random.randint(1000, 9999)}",
                    vehicle_type=random.choice(["Heavy Truck", "Delivery Van", "Transport Bus"]),
                    model=random.choice(["Tata Prima", "Mahindra Bolero", "Ashok Leyland"]),
                    manufacturer=random.choice(["Tata", "Mahindra", "Ashok Leyland"]),
                    fuel_capacity=random.uniform(50, 300)
                )
            self.stdout.write('Vehicles seeded!')
            
        # Seed Trips
        if Trip.objects.count() == 0:
            vehicles = list(Vehicle.objects.all())
            drivers = list(Driver.objects.all())
            for i in range(5):
                Trip.objects.create(
                    vehicle=random.choice(vehicles),
                    driver=random.choice(drivers),
                    start_time="2024-10-07T08:00:00Z",
                    status="IN_PROGRESS",
                    start_location="Chennai Port",
                    end_location="Guindy Industrial Estate",
                    distance_km=random.uniform(10, 50)
                )
            self.stdout.write('Trips seeded!')

        self.stdout.write(self.style.SUCCESS('Database fully seeded!'))
