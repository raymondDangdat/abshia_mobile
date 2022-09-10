// To parse this JSON data, do
//
//     final bookAppointmentModel = bookAppointmentModelFromJson(jsonString);

import 'dart:convert';

BookAppointmentModel bookAppointmentModelFromJson(String str) => BookAppointmentModel.fromJson(json.decode(str));

String bookAppointmentModelToJson(BookAppointmentModel data) => json.encode(data.toJson());

class BookAppointmentModel {
  BookAppointmentModel({
    this.title,
    this.appointmentReason,
    this.appointmentDate,
  });

  String? title;
  String? appointmentReason;
  DateTime? appointmentDate;

  factory BookAppointmentModel.fromJson(Map<String, dynamic> json) => BookAppointmentModel(
    title: json["title"],
    appointmentReason: json["appointment_reason"],
    appointmentDate: DateTime.parse(json["appointment_date"]),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "appointment_reason": appointmentReason,
    "appointment_date": "${appointmentDate!.year.toString().padLeft(4, '0')}-${appointmentDate!.month.toString().padLeft(2, '0')}-${appointmentDate!.day.toString().padLeft(2, '0')}",
  };
}
