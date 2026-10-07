import time
import random
from django.core.management.base import BaseCommand
from core.models import Vehicle, Driver, Telemetry

class Command(BaseCommand):
    help = 'Runs the IoT Fleet Tracking Telemetry Simulator'

    def handle(self, *args, **kwargs):
        self.stdout.write(self.style.SUCCESS('[Simulator] Starting...'))
        
        # Ensure base data exists
        if Vehicle.objects.count() == 0:
            self.stdout.write('[Simulator] Generating initial vehicles...')
            for i in range(1, 16):
                Vehicle.objects.create(
                    registration_no=f"TN{random.randint(10, 99)}AB{random.randint(1000, 9999)}",
                    vehicle_type=random.choice(["Truck", "Van", "Car"]),
                    model=random.choice(["Tata Prima", "Mahindra Bolero", "Ashok Leyland"]),
                    manufacturer=random.choice(["Tata", "Mahindra", "Ashok Leyland"]),
                    fuel_capacity=random.uniform(50, 300)
                )
        
        vehicles = list(Vehicle.objects.all())
        
        self.stdout.write(self.style.SUCCESS('[Simulator] Entering telemetry loop (Ctrl+C to stop)...'))
        try:
            while True:
                for v in vehicles:
                    # Generate some random movement around Chennai coordinates
                    lat = 13.0827 + random.uniform(-0.1, 0.1)
                    lng = 80.2707 + random.uniform(-0.1, 0.1)
                    speed = random.uniform(0, 80)
                    fuel = random.uniform(10, 100)
                    
                    Telemetry.objects.create(
                        vehicle=v,
                        latitude=lat,
                        longitude=lng,
                        speed=speed,
                        fuel_level=fuel
                    )
                self.stdout.write(f"Generated telemetry for {len(vehicles)} vehicles.")
                time.sleep(5)
        except KeyboardInterrupt:
            self.stdout.write(self.style.WARNING('\n[Simulator] Stopped.'))
