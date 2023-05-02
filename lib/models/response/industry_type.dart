class IndustryType {

  final int? indId;
  final String? IndName;

  IndustryType({this.indId,this.IndName});

  factory IndustryType.fromJson(Map<String, dynamic> json) => IndustryType(
    indId: json["in_id"],
    IndName: json["in_name"],

  );
}