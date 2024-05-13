import 'dart:io';

class MeteoTopicItem {
  String name;
  File? image; // Fayl turida rasm

  MeteoTopicItem({required this.name, this.image});

  // Factory method to convert from JSON
  factory MeteoTopicItem.fromJson(Map<String, dynamic> json) {
    return MeteoTopicItem(
      name: json['name'],

      // Image ni bu yerda o'qib olishingiz kerak emas, chunki
      // ma'lumotlar bazasida rasmlar o'rnini korsatmaydi
    );
  }

  set imageUrl(String imageUrl) {}

  // Method to convert to JSON
  Map<String, dynamic> toJson() {
    // Image ma'lumotlar bazasiga yuklab olinganligini belgilash uchun URL ni qo'shamiz, agar mavjud bo'lsa
    Map<String, dynamic> json = {
      'name': name,
      // 'image' qismiga URL qo'shamiz, agar rasmda mavjud bo'lsa
      if (image != null)
        'image':
            image, // imageUrl ni rasmda yuklab olish funksiyasidan qaytadigan joyga almashtiring
    };

    return json;
  }
}
