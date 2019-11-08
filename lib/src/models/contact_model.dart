// To parse this JSON data, do
//
//     final contactoModel = contactoModelFromJson(jsonString);

// import 'dart:convert';

// ContactoModel contactoModelFromJson(String str) => ContactoModel.fromJson(json.decode(str));

// String contactoModelToJson(ContactoModel data) => json.encode(data.toJson());

class ContactModel {
    int id;
    String name;
    String surename;
    int phone;
    int secondPhone;
    String email;

    ContactModel({
        this.id,
        this.name,
        this.surename,
        this.phone,
        this.secondPhone,
        this.email,
    });

    factory ContactModel.fromJson(Map<String, dynamic> json) => new ContactModel(
        id:           json["id"],
        name:         json["name"],
        surename:     json["surename"],
        phone:        json["phone"],
        secondPhone:  json["secondPhone"],
        email:        json["email"],
    );

    Map<String, dynamic> toJson() => {
        "id":           id,
        "name":         name,
        "surename":     surename,
        "phone":        phone,
        "secondPhone":  secondPhone,
        "email":        email,
    };
}