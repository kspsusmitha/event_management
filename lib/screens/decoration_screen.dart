import 'package:carousel_slider/carousel_slider.dart';
import 'package:event_management/screens/service_detail_screen.dart';
import 'package:event_management/utils/theme.dart';
import 'package:flutter/material.dart';

class DecorationScreen extends StatefulWidget {
  const DecorationScreen({Key? key}) : super(key: key);

  @override
  State<DecorationScreen> createState() => _DecorationScreenState();
}

class _DecorationScreenState extends State<DecorationScreen> {
  int _current = 0;

  final List<Map<String, String>> decorators1 = [
    {
      'image': 'assets/images/decoration1.jpg',
      'name': 'Elegant Events',
      'location': 'Manhattan, NY',
      'price': '\$2000/event',
      'style': 'Modern & Contemporary'
    },
    {
      'image': 'assets/images/decoration2.jpg',
      'name': 'Royal Decorators',
      'location': 'Beverly Hills, LA',
      'price': '\$2500/event',
      'style': 'Traditional & Classic'
    },
    {
      'image': 'assets/images/decoration3.jpg',
      'name': 'Creative Designs',
      'location': 'Chicago',
      'price': '\$1800/event',
      'style': 'Rustic & Vintage'
    },
    {
      'image': 'assets/images/decoration4.jpg',
      'name': 'Floral Fantasy',
      'location': 'Miami Beach',
      'price': '\$2200/event',
      'style': 'Tropical & Bohemian'
    },
    {
      'image': 'assets/images/decoration5.jpg',
      'name': 'Dream Decor',
      'location': 'San Francisco',
      'price': '\$2300/event',
      'style': 'Minimalist & Elegant'
    },
  ];
  final List<Map<String, String>> decorators2 = [
    {
      'image1': 'assets/images/decoration6.jpg',
      'image2': 'assets/images/decoration7.jpg',
      'image3': 'assets/images/decoration8.jpg',
      'name': 'Elegant Events',
      'location': 'Manhattan, NY',
      'price': '\$2000/event',
      'style': 'Modern & Contemporary'
    },
    {
        'image1': 'assets/images/decoration9.jpg',
      'image2': 'assets/images/decoration10.jpg',
      'image3': 'assets/images/decoration11.jpg',
      'name': 'Royal Decorators',
      'location': 'Beverly Hills, LA',
      'price': '\$2500/event',
      'style': 'Traditional & Classic'
    },
    {
      'image1': 'assets/images/decoration12.jpg',
      'image2': 'assets/images/decoration13.jpg',
      'image3': 'assets/images/decoration14.jpg',
      'name': 'Creative Designs',
      'location': 'Chicago',
      'price': '\$1800/event',
      'style': 'Rustic & Vintage'
    },
    {
       'image1': 'assets/images/decoration15.jpg',
      'image2': 'assets/images/decoration16.jpg',
      'image3': 'assets/images/decoration17.jpg',
      'name': 'Floral Fantasy',
      'location': 'Miami Beach',
      'price': '\$2200/event',
      'style': 'Tropical & Bohemian'
    },
    {
        'image1': 'assets/images/decoration18.jpg',
      'image2': 'assets/images/decoration19.jpg',
      'image3': 'assets/images/decoration20.jpg',
      'name': 'Dream Decor',
      'location': 'San Francisco',
      'price': '\$2300/event',
      'style': 'Minimalist & Elegant'
    },
  ];

  Widget _buildImageWithError(String imagePath, {double? width, double? height}) {
    return Image.asset(
      imagePath,
      width: width,
      height: height,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
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
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    'Image not found: ${imagePath.split('/').last}',
                    style: TextStyle(color: Colors.grey[600]),
                    textAlign: TextAlign.center,
                  ),
                ),
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
        title: const Text('Decoration',
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
            items: decorators1.map((decorator) {
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
                        decorator['image']!,
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
                            decorator['name']!,
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
            children: decorators2.asMap().entries.map((entry) {
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
              'Available Decorators',
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
            itemCount: decorators2.length,
            itemBuilder: (context, index) {
              final decorator = decorators2[index];
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
                      decorator['image1']!,
                      width: 80,
                      height: 80,
                    ),
                  ),
                  title: Text(
                    decorator['name']!,
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
                              decorator['location']!,
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
                                decorator['price']!,
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
                                Icons.style,
                                size: 16,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                decorator['style']!,
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
                            serviceData: decorator,
                            type: 'decorator',
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