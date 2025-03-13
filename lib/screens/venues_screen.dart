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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Venues',
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
            items: venues1.map((venue) {
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
                      Image.asset(
                        venue['image']!,
                        fit: BoxFit.cover,
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
                            venue['name']!,
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
            children: venues2.asMap().entries.map((entry) {
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
              'Available Venues',
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
            itemCount: venues2.length,
            itemBuilder: (context, index) {
              final venue = venues2[index];
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
                              venue['location']!,
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
                                venue['price']!,
                                style: const TextStyle(
                                  color: Color(0xFF8A2BE2),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            venue['capacity']!,
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
                            serviceData: venue,
                            type: 'venue',
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
