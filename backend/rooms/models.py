from django.db import models

class RoomEntry(models.Model):
    FIXED_PRICE_CHOICES = [
        (800, '800'),
        (900, '900'),
        (1000, '1000'),
        (1100, '1100'),
        (1200, '1200'),
        (1300, '1300'),
        (1400, '1400'),
        (1500, '1500'),
        (1600, '1600'),
        (1700, '1700'),
        (1800, '1800'),
        (1900, '1900'),
        (2000, '2000'),
    ]

    fixed_price = models.IntegerField(choices=FIXED_PRICE_CHOICES, null=True, blank=True)
    custom_price = models.DecimalField(max_digits=10, decimal_places=2, null=True, blank=True)
    additional_notes = models.TextField(blank=True, default="")
    nepali_date = models.CharField(max_length=20, help_text="Enter date in Nepali format (e.g., 2080-03-15)")

    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        price = self.fixed_price if self.fixed_price else self.custom_price
        return f"RoomEntry: {price} on {self.nepali_date}"
