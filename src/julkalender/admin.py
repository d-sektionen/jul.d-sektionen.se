from django.contrib import admin
from django.urls import reverse
from django.utils.html import format_html

from .models import Door


@admin.register(Door)
class DoorAdmin(admin.ModelAdmin):
    list_display = ("contributor", "year", "day", "preview_url")
    list_filter = ("year", "day")

    @admin.display(description="Preview")
    def preview_url(self, obj):
        url = reverse('door', args=[obj.year, obj.day])
        return format_html("<a href='{url}'>{url}</a>", url=url)
