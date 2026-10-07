from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import VehicleViewSet, DriverViewSet, TripViewSet, TelemetryViewSet, MaintenanceViewSet

router = DefaultRouter()
router.register(r'vehicles', VehicleViewSet)
router.register(r'drivers', DriverViewSet)
router.register(r'trips', TripViewSet)
router.register(r'telemetry', TelemetryViewSet)
router.register(r'maintenance', MaintenanceViewSet)

urlpatterns = [
    path('', include(router.urls)),
]
