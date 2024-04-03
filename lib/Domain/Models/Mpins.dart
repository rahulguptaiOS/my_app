class Mpin {
  final DateTime time;
  final String pin;

  Mpin({required this.time, required this.pin});

  Map<String, dynamic> toJson() {
    return {
      'time': time.toIso8601String(),
      'pin': pin,
    };
  }

  // Create a User object from JSON
  factory Mpin.fromJson(Map<String, dynamic> json) {
    return Mpin(
      time: DateTime.parse(json['time']),
      pin: json['pin'],
    );
  }
}