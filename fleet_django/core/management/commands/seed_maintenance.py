import random
from django.core.management.base import BaseCommand
from core.models import Vehicle, Maintenance

class Command(BaseCommand):
    help = 'Seeds maintenance data'
    def handle(self, *args, **kwargs):
        vehicles = list(Vehicle.objects.all())
        if Maintenance.objects.count() == 0 and vehicles:
            for i in range(10):
                Maintenance.objects.create(
                    vehicle=random.choice(vehicles),
                    description=random.choice(["Oil Change", "Brake Pad Replacement", "Engine Tuning", "Tire Rotation"]),
                    cost=random.uniform(100, 2000),
                    status=random.choice(["COMPLETED", "SCHEDULED"])
                )
            self.stdout.write('Maintenance seeded!')
