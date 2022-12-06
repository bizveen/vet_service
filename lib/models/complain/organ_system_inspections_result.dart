class OrganSystemInspectionsResult {


  OrganSystemInspectionsResult({
    this.id,
    this.name,
    this.duration,
    this.isSelected = false,
    this.comment

  });

  OrganSystemInspectionsResult.fromJson(dynamic json , String key) {
    id = json['id'] ?? key;
    name = json['name'];
    comment = json['comment'];
    duration = json['duration'];
    isSelected = json['isSelected'] ?? false;

  }

  String? id;
  String? name;
  String? duration;
  String? comment;
  bool? isSelected;

  OrganSystemInspectionsResult copyWith({
    String? id,
    String? name,
    String? duration,
    String? comment,
    bool? isSelected,

  }) =>
      OrganSystemInspectionsResult(
        id: id ?? this.id,
        name: name ?? this.name,
        comment: comment ?? this.comment,
        duration: duration ?? this.duration,
        isSelected: isSelected ?? this.isSelected,

      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['isSelected'] = isSelected;
    map['comment'] = comment;
    map['duration'] = duration;

    return map;
  }

}

