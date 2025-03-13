class OrderIdGenerator {
  static String generate() {
    // Get current timestamp
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    
    // Take last 5 digits of timestamp
    final timestampStr = timestamp.toString().substring(timestamp.toString().length - 5);
    
    // Format to match your design (124450)
    return timestampStr;
  }
} 