from django.db import models
from django.conf import settings


class ExpenseEntry(models.Model):
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, default=1)
    CATEGORY_CHOICES = [
        ('electricity', 'Electricity'),
        ('staff_salary', 'Staff Salary'),
        ('water', 'Water'),
        ('maintenance', 'Maintenance'),
        ('others', 'Others'),
    ]

    category = models.CharField(max_length=20, choices=CATEGORY_CHOICES)
    amount = models.DecimalField(max_digits=10, decimal_places=2)
    remarks = models.TextField(blank=True, default='')
    nepali_date = models.CharField(
        max_length=20,
        help_text="Enter date in Nepali format (e.g., 2080-03-15)"
    )

    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f"{self.get_category_display()} - {self.amount} on {self.nepali_date}"
