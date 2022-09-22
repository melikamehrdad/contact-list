//Contact Model
class Contact {
  Contact({
    required this.links,
    required this.count,
    required this.data,
  });

  final List<Link> links;
  final String count;
  final List<Datum> data;

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        links: json["_links"] == null
            ? []
            : List<Link>.from(json["_links"].map((x) => Link.fromJson(x))),
        count: json["count"] ?? "0",
        data: json["data"] == null ? [] : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_links": List<dynamic>.from(links.map((x) => x.toJson())),
        "count": count,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.firstName,
    required this.notes,
    required this.phone,
    required this.email,
    required this.picture,
    required this.lastName,
    required this.createdAt,
  });

  final String id;
  final String firstName;
  final String notes;
  final String phone;
  final String email;
  final List<String> picture;
  final String lastName;
  final DateTime createdAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] ?? " ",
        firstName: json["firstName"] ?? " ",
        notes: json["notes"] ?? " ",
        phone: json["phone"] ?? " ",
        email: json["email"] ?? " ",
        picture: json["picture"] == null
            ? [" "]
            : List<String>.from(json["picture"].map((x) => x)),
        lastName: json["lastName"] ?? " ",
        createdAt: json["created_at"] == null
            ? DateTime.now()
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "notes": notes,
        "phone": phone,
        "email": email,
        "picture": List<dynamic>.from(picture.map((x) => x)),
        "lastName": lastName,
        "created_at": createdAt.toIso8601String(),
      };
}

class Link {
  Link({
    required this.rel,
    required this.href,
  });

  final String rel;
  final String href;

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        rel: json["rel"],
        href: json["href"],
      );

  Map<String, dynamic> toJson() => {
        "rel": rel,
        "href": href,
      };
}
