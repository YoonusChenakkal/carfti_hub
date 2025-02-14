class UserModel {
  final int id;
  final String name;
  final String contactNumber;
  final String whatsappNumber;
  final String email;
  final String? otp;
  final String displayImage;
  final bool isActive;
  final bool isApproved;
  final String? otpExpiry;
  final String createdAt;
  final bool isFullyActive;

  UserModel({
    required this.id,
    required this.name,
    required this.contactNumber,
    required this.whatsappNumber,
    required this.email,
    this.otp,
    required this.displayImage,
    required this.isActive,
    required this.isApproved,
    this.otpExpiry,
    required this.createdAt,
    required this.isFullyActive,
  });

  // Factory constructor to create a UserModel from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      contactNumber: json['contact_number'],
      whatsappNumber: json['whatsapp_number'],
      email: json['email'],
      otp: json['otp'],
      displayImage: json['display_image'],
      isActive: json['is_active'],
      isApproved: json['is_approved'],
      otpExpiry: json['otp_expiry'],
      createdAt: json['created_at'],
      isFullyActive: json['is_fully_active'],
    );
  }
}
