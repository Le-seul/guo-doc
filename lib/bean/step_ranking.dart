class Stepranking{
  String name ="张警官";
  int step;
  int rank;
  String imagePath;

  Stepranking.fromMap(Map<String, dynamic> map) {
    name = map['name'];
    step = map['step'];
    rank = map['rank'];
    imagePath = map['imagePath'];
  }
}