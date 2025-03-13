import 'package:carousel_slider/carousel_slider.dart';
import 'package:event_management/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:event_management/screens/service_detail_screen.dart';

class PhotographyScreen extends StatefulWidget {
  const PhotographyScreen({Key? key}) : super(key: key);

  @override
  State<PhotographyScreen> createState() => _PhotographyScreenState();
}

class _PhotographyScreenState extends State<PhotographyScreen> {
  int _current = 0;

  final List<Map<String, String>> photographers1 = [
    {
      'image': 'assets/images/photography1.jpg',
      'name': 'John Smith Photography',
      'location': 'New York City',
      'price': '\$1000/event',
      'experience': '10 years experience'
    },
    {
      'image': 'assets/images/photography2.jpg',
      'name': 'Sarah Williams Studio',
      'location': 'Los Angeles',
      'price': '\$1200/event',
      'experience': '8 years experience'
    },
    {
      'image': 'assets/images/photography3.jpg',
      'name': 'Michael Brown Photos',
      'location': 'Chicago',
      'price': '\$900/event',
      'experience': '12 years experience'
    },
    {
      'image': 'assets/images/photography4.jpg',
      'name': 'Emma Davis Photography',
      'location': 'Miami',
      'price': '\$1100/event',
      'experience': '7 years experience'
    },
    {
      'image': 'assets/images/photography5.jpg',
      'name': 'David Wilson Studio',
      'location': 'San Francisco',
      'price': '\$1300/event',
      'experience': '15 years experience'
    },
  ];
   final List<Map<String, String>> photographers2 = [
    {
      'image1': 'assets/images/photography6.jpg',
       'image2': 'assets/images/photography7.jpg',
        'image3': 'assets/images/photography8.jpg',
      'name': 'John Smith Photography',
      'location': 'New York City',
      'price': '\$1000/event',
      'experience': '10 years experience'
    },
    {
       'image1': 'assets/images/photography9.jpg',
       'image2': 'assets/images/photography10.jpg',
        'image3': 'assets/images/photography11.jpg',
      'name': 'Sarah Williams Studio',
      'location': 'Los Angeles',
      'price': '\$1200/event',
      'experience': '8 years experience'
    },
    {
       'image1': 'assets/images/photography12.jpg',
       'image2': 'assets/images/photography13.jpg',
        'image3': 'assets/images/photography14.jpg',
      'name': 'Michael Brown Photos',
      'location': 'Chicago',
      'price': '\$900/event',
      'experience': '12 years experience'
    },
    {
      'image1': 'assets/images/photography15.jpg',
       'image2': 'assets/images/photography16.jpg',
        'image3': 'assets/images/photography17.jpg',
      'name': 'Emma Davis Photography',
      'location': 'Miami',
      'price': '\$1100/event',
      'experience': '7 years experience'
    },
    {
      'image1': 'assets/images/photography18.jpg',
       'image2': 'assets/images/photography19.jpg',
        'image3': 'assets/images/photography20.jpg',
      'name': 'David Wilson Studio',
      'location': 'San Francisco',
      'price': '\$1300/event',
      'experience': '15 years experience'
    },
  ];

  Widget _buildImageWithError(String imagePath, {double? width, double? height}) {
    return Image.asset(
      imagePath,
      width: width,
      height: height,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        print('Debug: Trying to load $imagePath');
        debugPrint('Error loading image: $imagePath');
        debugPrint('Error details: $error');
        return Container(
          width: width,
          height: height,
          color: Colors.grey[300],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red),
              const SizedBox(height: 8),
              Text(
                'Image not found: ${imagePath.split('/').last}',
                style: TextStyle(color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photography',
          style: TextStyle(
          color: Colors.white
        ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: AppTheme.primaryColor,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 20),
          CarouselSlider(
            items: photographers1.map((photographer) {
              return Container(
                margin: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Stack(
                    children: [
                      _buildImageWithError(
                        photographer['image']!,
                        width: double.infinity,
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Colors.black.withOpacity(0.8),
                                Colors.transparent,
                              ],
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 16,
                          ),
                          child: Text(
                            photographer['name']!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
            options: CarouselOptions(
              height: 300.0,
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              viewportFraction: 0.8,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              },
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: photographers2.asMap().entries.map((entry) {
              return Container(
                width: 12.0,
                height: 12.0,
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF8A2BE2).withOpacity(
                    _current == entry.key ? 0.9 : 0.4,
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Available Photographers',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: photographers2.length,
            itemBuilder: (context, index) {
              final photographer = photographers2[index];
              return Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: _buildImageWithError(
                      photographer['image1']!,
                      width: 80,
                      height: 80,
                    ),
                  ),
                  title: Text(
                    photographer['name']!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 16,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              photographer['location']!,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.attach_money,
                                size: 16,
                                color: Color(0xFF8A2BE2),
                              ),
                              Text(
                                photographer['price']!,
                                style: const TextStyle(
                                  color: Color(0xFF8A2BE2),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            photographer['experience']!,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ServiceDetailScreen(
                            serviceData: photographer,
                            type: 'photographer',
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}