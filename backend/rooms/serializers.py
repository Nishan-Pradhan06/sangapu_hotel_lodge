from rest_framework import serializers
from .models import RoomEntry

class RoomEntrySerializer(serializers.ModelSerializer):
    class Meta:
        model = RoomEntry
        fields = '__all__'
        read_only_fields = ('created_at', 'updated_at')

    def validate(self, data):
        # Allow partial updates to preserve existing values if not provided in the payload
        if self.instance:
            fixed_price = data.get('fixed_price', self.instance.fixed_price)
            custom_price = data.get('custom_price', self.instance.custom_price)
        else:
            fixed_price = data.get('fixed_price')
            custom_price = data.get('custom_price')

        if fixed_price is not None and custom_price is not None:
            raise serializers.ValidationError("You can only provide either a fixed price or a custom price, not both.")
        
        if fixed_price is None and custom_price is None:
            raise serializers.ValidationError("You must provide either a fixed price or a custom price.")

        return data
