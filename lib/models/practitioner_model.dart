class PractitionerModel {
  String name;
  String adultWorkoutsRequirement;
  String adultWorkouts;
  String seminarsRequirement;
  String seminars;
  String ukesRequirement;
  String ukes;

  PractitionerModel({
    required this.name,
    required this.adultWorkoutsRequirement,
    required this.adultWorkouts,
    required this.seminarsRequirement,
    required this.seminars,
    required this.ukesRequirement,
    required this.ukes,
  });

  PractitionerModel.toMap(Map<String, dynamic> map)
      : name = map["name"],
        adultWorkoutsRequirement = map["adultWorkoutsRequirement"],
        adultWorkouts = map["adultWorkouts"],
        seminarsRequirement = map["seminarsRequirement"],
        seminars = map["seminars"],
        ukesRequirement = map["ukesRequirement"],
        ukes = map["ukes"];

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "adultWorkoutsRequirement": adultWorkoutsRequirement,
      "adultWorkouts": adultWorkouts,
      "seminarsRequirement": seminarsRequirement,
      "seminars": seminars,
      "ukesRequirement": ukesRequirement,
      "ukes": ukes,
    };
  }
}
