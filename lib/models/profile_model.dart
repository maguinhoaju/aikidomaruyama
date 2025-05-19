class ProfileModel {
  String name;
  String startDate;
  String lastExamDate;
  String adultWorkoutsRequirement;
  String adultWorkouts;
  String seminarsRequirement;
  String seminars;
  String ukesRequirement;
  String ukes;

  ProfileModel({
    required this.name,
    required this.startDate,
    required this.lastExamDate,
    required this.adultWorkoutsRequirement,
    required this.adultWorkouts,
    required this.seminarsRequirement,
    required this.seminars,
    required this.ukesRequirement,
    required this.ukes,
  });

  ProfileModel.toMap(Map<String, dynamic> map)
      : name = map["name"],
        startDate = map["startDate"],
        lastExamDate = map["lastExamDate"],
        adultWorkoutsRequirement = map["adultWorkoutsRequirement"],
        adultWorkouts = map["adultWorkouts"],
        seminarsRequirement = map["seminarsRequirement"],
        seminars = map["seminars"],
        ukesRequirement = map["ukesRequirement"],
        ukes = map["ukes"];

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "startDate": startDate,
      "lastExamDate": lastExamDate,
      "adultWorkoutsRequirement": adultWorkoutsRequirement,
      "adultWorkouts": adultWorkouts,
      "seminarsRequirement": seminarsRequirement,
      "seminars": seminars,
      "ukesRequirement": ukesRequirement,
      "ukes": ukes,
    };
  }
}
