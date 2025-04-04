import 'package:carousel_slider/carousel_slider.dart';
import 'package:event_management/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:event_management/screens/service_detail_screen.dart';
//import 'package:carousel_slider/carousel_slider.dart';

class VenuesScreen extends StatefulWidget {
  const VenuesScreen({Key? key}) : super(key: key);

  @override
  State<VenuesScreen> createState() => _VenuesScreenState();
}

class _VenuesScreenState extends State<VenuesScreen> {
  int _current = 0;

  final List<Map<String, String>> venues1 = [
    {
      'image': 'assets/images/venue1.jpg',
      'name': 'Grand Palace',
      'location': 'City Center, New York',
      'price': '\$5000/day',
      'capacity': 'Up to 500 guests'
    },
    {
      'image': 'assets/images/venue2.jpg',
      'name': 'Royal Garden',
      'location': 'Downtown, Los Angeles',
      'price': '\$4500/day',
      'capacity': 'Up to 400 guests'
    },
    {
      'image': 'assets/images/venue3.jpg',
      'name': 'Seaside Resort',
      'location': 'Beach Road, Miami',
      'price': '\$6000/day',
      'capacity': 'Up to 300 guests'
    },
    {
      'image': 'assets/images/venue4.jpg',
      'name': 'Mountain View',
      'location': 'Highland Park, Denver',
      'price': '\$4000/day',
      'capacity': 'Up to 250 guests'
    },
    {
      'image': 'assets/images/venue5.jpg',
      'name': 'Luxury Hotel',
      'location': 'Main Street, Chicago',
      'price': '\$5500/day',
      'capacity': 'Up to 450 guests'
    },
  ];
  final List<Map<String, String>> venues2 = [
    {
      'image1': 'assets/images/venue6.jpg',
      'image2': 'assets/images/venue7.jpg',
      'image3': 'assets/images/venue8.jpg',
      'name': 'Grand Palace',
      'location': 'City Center, New York',
      'price': '\$5000/day',
      'capacity': 'Up to 500 guests'
    },
    {
      'image1': 'assets/images/venue9.jpg',
         'image2': 'assets/images/venue10.jpg',
      'image3': 'assets/images/venue11.jpg',
      'name': 'Royal Garden',
      'location': 'Downtown, Los Angeles',
      'price': '\$4500/day',
      'capacity': 'Up to 400 guests'
    },
    {
      'image1': 'assets/images/venue12.jpg',
         'image2': 'assets/images/venue13.jpg',
      'image3': 'assets/images/venue14.jpg',
      'name': 'Seaside Resort',
      'location': 'Beach Road, Miami',
      'price': '\$6000/day',
      'capacity': 'Up to 300 guests'
    },
    {
      'image1': 'assets/images/venue15.jpg',
         'image2': 'assets/images/venue16.jpg',
      'image3': 'assets/images/venue17.jpg',
      'name': 'Mountain View',
      'location': 'Highland Park, Denver',
      'price': '\$4000/day',
      'capacity': 'Up to 250 guests'
    },
    {
      'image1': 'assets/images/venue18.jpg',
         'image2': 'assets/images/venue19.jpg',
      'image3': 'assets/images/venue20.jpg',
      'name': 'Luxury Hotel',
      'location': 'Main Street, Chicago',
      'price': '\$5500/day',
      'capacity': 'Up to 450 guests'
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
            items: venues1.map((venue) {
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
                  borderRadius: BorderRadius.circular(16.0),
                  child: Stack(
                    children: [
                      Image.asset(
                        venue['image']!,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.7),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        left: 20,
                        right: 20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              venue['name']!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  color: Colors.white70,
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  venue['location']!,
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
            options: CarouselOptions(
              height: 300,
              aspectRatio: 16/9,
              viewportFraction: 0.8,
              enableInfiniteScroll: true,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              },
            ),
          ),
          const SizedBox(height: 20),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: venues2.length,
            itemBuilder: (context, index) {
              final venue = venues2[index];
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
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      venue['image1']!,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(
                    venue['name']!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 16,
                            color: Colors.white70,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              venue['location']!,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            venue['price']!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            venue['capacity']!,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  trailing: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ServiceDetailScreen(
                              serviceData: venue,
                              type: 'venue',
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
