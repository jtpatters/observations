class Dimension {
  int _id;
  String _name;
  int _observations;

  Dimension(this._name);

  Dimension.withId(this._id, this._name);

  int get id => _id;

  String get name => _name;

  int get observations => _observations;

  set name(String newName) {
    if (newName.length <= 255) {
      this._name = newName;
    }
  }

  set observations(int obs) {
    this._observations = obs;
  }

  // Convert a Dimension object into a Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['name'] = _name;
    return map;
  }

  // Extract a Note object from a Map object
  Dimension.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
  }
}
