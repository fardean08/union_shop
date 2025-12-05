// sample_collections.dart
import 'collection.dart';

final sampleCollections = [
  Collection(
    name: 'Hoodies',
    imageUrl: 'https://via.placeholder.com/400x400?text=Hoodies',
    products: [
      {
        'title': 'Classic Hoodie',
        'imageUrl': 'https://via.placeholder.com/400x400?text=Classic+Hoodie',
        'oldPrice': '£30.00',
        'price': '£24.99',
      },
      {
        'title': 'Zip Hoodie',
        'imageUrl': 'https://via.placeholder.com/400x400?text=Zip+Hoodie',
        'oldPrice': '£32.00',
        'price': '£26.99',
      },
      {
        'title': 'Premium Hoodie',
        'imageUrl': 'https://via.placeholder.com/400x400?text=Premium+Hoodie',
        'oldPrice': null,
        'price': '£34.99',
      },
    ],
  ),
  Collection(
    name: 'Jumpers',
    imageUrl: 'https://via.placeholder.com/400x400?text=Jumpers',
    products: [
      {
        'title': 'Crew Jumper',
        'imageUrl': 'https://via.placeholder.com/400x400?text=Crew+Jumper',
        'oldPrice': '£25.00',
        'price': '£19.99',
      },
      {
        'title': 'V-Neck Jumper',
        'imageUrl': 'https://via.placeholder.com/400x400?text=V-Neck+Jumper',
        'oldPrice': null,
        'price': '£21.99',
      },
      {
        'title': 'Lightweight Jumper',
        'imageUrl':
            'https://via.placeholder.com/400x400?text=Lightweight+Jumper',
        'oldPrice': null,
        'price': '£17.99',
      },
    ],
  ),
  Collection(
    name: 'Accessories',
    imageUrl: 'https://via.placeholder.com/400x400?text=Accessories',
    products: [
      {
        'title': 'Beanie',
        'imageUrl': 'https://via.placeholder.com/400x400?text=Beanie',
        'oldPrice': null,
        'price': '£7.99',
      },
      {
        'title': 'Scarf',
        'imageUrl': 'https://via.placeholder.com/400x400?text=Scarf',
        'oldPrice': '£10.00',
        'price': '£8.99',
      },
      {
        'title': 'Tote Bag',
        'imageUrl': 'https://via.placeholder.com/400x400?text=Tote+Bag',
        'oldPrice': null,
        'price': '£5.99',
      },
    ],
  ),
];
