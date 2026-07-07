from rest_framework import serializers
from .models import ExpenseEntry


class ExpenseEntrySerializer(serializers.ModelSerializer):
    class Meta:
        model = ExpenseEntry
        fields = '__all__'
        read_only_fields = ('created_at', 'updated_at', 'user')

    def validate(self, data):
        # For partial updates, fall back to existing value if not provided
        if self.instance:
            category = data.get('category', self.instance.category)
            remarks = data.get('remarks', self.instance.remarks)
        else:
            category = data.get('category')
            remarks = data.get('remarks', '')

        if category == 'others' and not remarks.strip():
            raise serializers.ValidationError(
                {"remarks": "Remarks are required when category is 'Others'. Please describe the expense."}
            )

        return data
