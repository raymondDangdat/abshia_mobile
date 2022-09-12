// To parse this JSON data, do
//
//     final plansModel = plansModelFromJson(jsonString);

import 'dart:convert';

PlansModel plansModelFromJson(String str) => PlansModel.fromJson(json.decode(str));

String plansModelToJson(PlansModel data) => json.encode(data.toJson());

class PlansModel {
  PlansModel({
    this.data,
    this.links,
    this.meta,
    this.message,
    this.success,
  });

  List<SubscriptionPlan>? data;
  dynamic links;
  Meta? meta;
  dynamic message;
  bool? success;

  factory PlansModel.fromJson(Map<String, dynamic> json) => PlansModel(
    data: List<SubscriptionPlan>.from(json["data"].map((x) => SubscriptionPlan.fromJson(x))),
    links: Links.fromJson(json["links"]),
    meta: Meta.fromJson(json["meta"]),
    message: json["message"],
    success: json["success"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "links": links.toJson(),
    "meta": meta!.toJson(),
    "message": message,
    "success": success,
  };
}

class SubscriptionPlan {
  SubscriptionPlan({
    this.id,
    this.title,
    this.description,
    this.duration,
    this.cost,
    this.slug,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  dynamic id;
  dynamic title;
  dynamic description;
  dynamic duration;
  dynamic cost;
  dynamic slug;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  factory SubscriptionPlan.fromJson(Map<String, dynamic> json) => SubscriptionPlan(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    duration: json["duration"],
    cost: json["cost"],
    slug: json["slug"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "duration": duration,
    "cost": cost,
    "slug": slug,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "deleted_at": deletedAt,
  };
}

class Links {
  Links({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  dynamic first;
  dynamic last;
  dynamic prev;
  dynamic next;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    first: json["first"],
    last: json["last"],
    prev: json["prev"],
    next: json["next"],
  );

  Map<String, dynamic> toJson() => {
    "first": first,
    "last": last,
    "prev": prev,
    "next": next,
  };
}

class Meta {
  Meta({
    this.currentPage,
    this.from,
    this.lastPage,
    this.links,
    this.path,
    this.perPage,
    this.to,
    this.total,
  });

  dynamic currentPage;
  dynamic from;
  dynamic lastPage;
  List<Link>? links;
  dynamic path;
  dynamic perPage;
  dynamic to;
  dynamic total;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    currentPage: json["current_page"],
    from: json["from"],
    lastPage: json["last_page"],
    links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
    path: json["path"],
    perPage: json["per_page"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "from": from,
    "last_page": lastPage,
    "links": List<dynamic>.from(links!.map((x) => x.toJson())),
    "path": path,
    "per_page": perPage,
    "to": to,
    "total": total,
  };
}

class Link {
  Link({
    this.url,
    this.label,
    this.active,
  });

  dynamic url;
  dynamic label;
  bool? active;

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"] == null ? null : json["url"],
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "url": url == null ? null : url,
    "label": label,
    "active": active,
  };
}
