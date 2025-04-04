import 'package:carousel_slider/carousel_slider.dart';
import 'package:event_management/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:event_management/screens/service_detail_screen.dart';

class CateringScreen extends StatefulWidget {
  const CateringScreen({Key? key}) : super(key: key);

  @override
  State<CateringScreen> createState() => _CateringScreenState();
}

class _CateringScreenState extends State<CateringScreen> {
  int _current = 0;

  final List<Map<String, String>> caterers1 = [
    {
      'image': 'assets/images/catering1.jpg',
      'name': 'Royal Catering',
      'location': 'Manhattan, NY',
      'price': '\$50/plate',
      'specialty': 'Multi-cuisine'
    },
    {
      'image': 'assets/images/catering2.jpg',
      'name': 'Gourmet Delights',
      'location': 'Beverly Hills, LA',
      'price': '\$65/plate',
      'specialty': 'Continental'
    },
    {
      'image': 'assets/images/catering3.jpg',
      'name': 'Taste of India',
      'location': 'Chicago',
      'price': '\$45/plate',
      'specialty': 'Indian Cuisine'
    },
    {
      'image': 'assets/images/catering4.jpg',
      'name': 'Mediterranean Feast',
      'location': 'Miami Beach',
      'price': '\$55/plate',
      'specialty': 'Mediterranean'
    },
    {
      'image': 'assets/images/catering5.jpg',
      'name': 'Asian Fusion',
      'location': 'San Francisco',
      'price': '\$60/plate',
      'specialty': 'Pan Asian'
    },
  ];
  final List<Map<String, String>> caterers2 = [
    {
      'image1': 'assets/images/catering6.jpg',
       'image2': 'assets/images/catering7.jpg',
        'image3': 'assets/images/catering8.jpg',
      'name': 'Royal Catering',
      'location': 'Manhattan, NY',
      'price': '\$50/plate',
      'specialty': 'Multi-cuisine'
    },
    {
        'image1': 'assets/images/catering9.jpg',
       'image2': 'assets/images/catering10.jpg',
        'image3': 'assets/images/catering11.jpg',
      'name': 'Gourmet Delights',
      'location': 'Beverly Hills, LA',
      'price': '\$65/plate',
      'specialty': 'Continental'
    },
    {
        'image1': 'assets/images/catering12.jpg',
       'image2': 'assets/images/catering13.jpg',
        'image3': 'assets/images/catering14.jpg',
      'name': 'Taste of India',
      'location': 'Chicago',
      'price': '\$45/plate',
      'specialty': 'Indian Cuisine'
    },
    {
      'image1': 'assets/images/catering15.jpg',
       'image2': 'assets/images/catering16.jpg',
        'image3': 'assets/images/catering17.jpg',
      'name': 'Mediterranean Feast',
      'location': 'Miami Beach',
      'price': '\$55/plate',
      'specialty': 'Mediterranean'
    },
    {
       'image1': 'assets/images/catering18.jpg',
       'image2': 'assets/images/catering19.jpg',
        'image3': 'assets/images/catering20.jpg',
      'name': 'Asian Fusion',
      'location': 'San Francisco',
      'price': '\$60/plate',
      'specialty': 'Pan Asian'
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color.fromARGB(255, 72, 20, 72).withOpacity(0.9),  // Purple
            const Color(0xFF4A148C).withOpacity(0.9),  // Darker purple
          ],
        ),
      ),
      child: ListView(
        children: [
          const SizedBox(height: 20),
          CarouselSlider(
            items: caterers1.map((caterer) {
              return Container(
                margin: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Stack(
                    children: [
                      _buildImageWithError(
                        caterer['image']!,
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
                            caterer['name']!,
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
            children: caterers2.asMap().entries.map((entry) {
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
              'Available Caterers',
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
            itemCount: caterers2.length,
            itemBuilder: (context, index) {
              final caterer = caterers2[index];
              return Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withOpacity(0.1),
                      Colors.white.withOpacity(0.05),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: _buildImageWithError(
                      caterer['image1']!,
                      width: 80,
                      height: 80,
                    ),
                  ),
                  title: Text(
                    caterer['name']!,
                    style: const TextStyle(
                      color: Colors.white,
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
                              caterer['location']!,
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
                                caterer['price']!,
                                style: const TextStyle(
                                  color: Color(0xFF8A2BE2),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.restaurant_menu,
                                size: 16,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                caterer['specialty']!,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ],
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
                            serviceData: caterer,
                            type: 'caterer',
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
} 