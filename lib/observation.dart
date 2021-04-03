class Observation {
  int _id;
  int _dimId;
  String _quality;
  String _comments;
  DateTime _date;

  int get id => _id;
  String get quality => _quality;
  String get comments => _comments;
  DateTime get date => _date;

  set comments(String newComments) {
    if (newComments.length <= 255) {
      this._comments = newComments;
    }
  }

  // Convert a Observation object into a Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['dim_id'] = _dimId;
    map['quality'] = _quality;
    map['comments'] = _comments;
    return map;
  }
}
