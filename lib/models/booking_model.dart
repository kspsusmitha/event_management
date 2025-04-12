// lib/models/booking_model.dart

class BookingModel {
  final String userId;
  final String orderId;
  final String serviceName;
  final String name;
  final String phone;
  final String email;
  final int guests;
  final String functionType;
  final String eventDate;
  final String status;
  final String createdAt;

  BookingModel({
    required this.userId,
    required this.orderId,
    required this.serviceName,
    required this.name,
    required this.phone,
    required this.email,
    required this.guests,
    required this.functionType,
    required this.eventDate,
    required this.status,
    required this.createdAt,
  });

  // Convert booking to JSON for Firebase
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'orderId': orderId,
      'serviceName': serviceName,
      'name': name,
      'phone': phone,
      'email': email,
      'guests': guests,
      'functionType': functionType,
      'eventDate': eventDate,
      'status': status,
      'createdAt': createdAt,
    };
  }

  // Create booking from Firebase JSON data
  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      userId: json['userId'] ?? '',
      orderId: json['orderId'] ?? '',
      serviceName: json['serviceName'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      guests: json['guests'] ?? 0,
      functionType: json['functionType'] ?? '',
      eventDate: json['eventDate'] ?? '',
      status: json['status'] ?? '',
      createdAt: json['createdAt'] ?? '',
    );
  }

  // Copy with method to create a new instance with some modified fields
  BookingModel copyWith({
    String? userId,
    String? orderId,
    String? serviceName,
    String? name,
    String? phone,
    String? email,
    int? guests,
    String? functionType,
    String? eventDate,
    String? status,
    String? createdAt,
  }) {
    return BookingModel(
      userId: userId ?? this.userId,
      orderId: orderId ?? this.orderId,
      serviceName: serviceName ?? this.serviceName,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      guests: guests ?? this.guests,
      functionType: functionType ?? this.functionType,
      eventDate: eventDate ?? this.eventDate,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() {
    return 'BookingModel(userId: $userId, orderId: $orderId, serviceName: $serviceName, name: $name, phone: $phone, email: $email, guests: $guests, functionType: $functionType, eventDate: $eventDate, status: $status, createdAt: $createdAt)';
  }
}