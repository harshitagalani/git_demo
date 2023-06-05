class modal {
  String? id;
  String? name;
  String? contact;
  String? image;

  modal({this.id, this.name, this.contact, this.image});

  modal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    contact = json['contact'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['contact'] = this.contact;
    data['image'] = this.image;
    return data;
  }
}