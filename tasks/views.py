from rest_framework import viewsets
from .models import Tarea
from .serializers import TareaSerializer
from rest_framework.permissions import IsAuthenticated

class TareaViewSet(viewsets.ModelViewSet):
    serializer_class = TareaSerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        return Tarea.objects.filter(usuario=self.request.user)

    def perform_create(self, serializer):
        serializer.save(usuario=self.request.user)
