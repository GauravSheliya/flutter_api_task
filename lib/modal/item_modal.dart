class ItemModal {
  String? image;
  String? id;
  String? title;
  String? subtitle;

  ItemModal(
      {this.image, this.id, this.title, this.subtitle});

  ItemModal.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    id = json['id'];
    title = json['title'];
    subtitle = json['subtitle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['id'] = this.id;
    data['title'] = this.title;
    data['subtitle'] = this.subtitle;
    return data;
  }
}