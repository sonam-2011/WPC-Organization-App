class JobCategory {
  final int? catId;
  final String? catName;

  JobCategory({this.catId,this.catName});

  factory JobCategory.fromJson(Map<String, dynamic> json) => JobCategory(
    catId: json["cat_id"],
    catName: json["cat_name"],

  );
}