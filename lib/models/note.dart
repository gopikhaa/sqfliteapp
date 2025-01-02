class Note {
  int? _id;
  late String _title; // Marked late to defer initialization
  String? _description; // Nullable, so no need for `late`
  late String _date; // Marked late
  late int _priority; // Marked late

  // Constructors
  Note(this._title, this._date, this._priority, [this._description]);
  Note.withId(this._id, this._title, this._date, this._priority, [this._description]);

  // Getters
  int? get id => _id;
  String get title => _title;
  String? get description => _description;
  String get date => _date;
  int get priority => _priority;

  // Setters with validation
  set title(String newTitle) {
    if (newTitle.length <= 255) {
      _title = newTitle;
    } else {
      throw Exception("Title must be 255 characters or less.");
    }
  }

  set description(String? newDescription) {
    if (newDescription == null || newDescription.length <= 255) {
      _description = newDescription;
    } else {
      throw Exception("Description must be 255 characters or less.");
    }
  }

  set priority(int newPriority) {
    if (newPriority >= 1 && newPriority <= 2) {
      _priority = newPriority;
    } else {
      throw Exception("Priority must be 1 or 2.");
    }
  }

  set date(String newDate) {
    _date = newDate;
  }

  // Convert a Note object to a Map object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    if (_id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['description'] = _description;
    map['priority'] = _priority;
    map['date'] = _date;
    return map;
  }

  // Extract a Note object from a Map object
  Note.fromMapObject(Map<String, dynamic> map) {
    _id = map['id'];
    _title = map['title']; // Ensure valid non-null field
    _date = map['date']; // Ensure valid non-null field
    _description = map['description'];
    _priority = map['priority']; // Ensure valid non-null field
  }
}
