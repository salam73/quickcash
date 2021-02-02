class Category {
  int categoryId;
  String categoryName;
  String categoryDesc;
  int parent;
  Image image;

  Category(
      {this.categoryId,
      this.categoryName,
      this.categoryDesc,
      this.parent,
      this.image});

  Category.fromJson(Map<String, dynamic> json) {
    categoryId = json['id'];
    categoryName = json['name'];
    categoryDesc = json['description'];
    parent = json['parent'];
    image = json['image'] != null ? new Image.fromJson(json['image']) : null;
  }

/*  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoryId'] = this.categoryId;
    data['categoryName'] = this.categoryName;
    data['categoryDesc'] = this.categoryDesc;
    data['parent'] = this.parent;
    if (this.image != null) {
      data['image'] = this.image.toJson();
    }
    return data;
  }*/
}

class Image {
  String url;

  Image({this.url});

  Image.fromJson(Map<String, dynamic> json) {
    url = json['src'];
  }

  /* Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    return data;
  }*/
}
