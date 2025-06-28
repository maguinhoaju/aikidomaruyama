class RequirementModel {
  String id;
  String belt;
  String adultWorkouts;
  String graduateWorkouts;
  String ukes;
  String years;
  String seminars;
  String evaluationBoards;

  RequirementModel({
    required this.id,
    required this.belt,
    required this.adultWorkouts,
    required this.graduateWorkouts,
    required this.ukes,
    required this.years,
    required this.seminars,
    required this.evaluationBoards,
  });

  RequirementModel.fromMap(Map<String, dynamic> map)
    : id = map["id"],
      belt = map["belt"],
      adultWorkouts = map["adultWorks"],
      graduateWorkouts = map["graduateWorkouts"],
      ukes = map["ukes"],
      years = map["years"],
      seminars = map["seminars"],
      evaluationBoards = map["evaluationBoards"];

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "belt": belt,
      "adultWorkouts": adultWorkouts,
      "graduateWorkouts": graduateWorkouts,
      "ukes": ukes,
      "years": years,
      "seminars": seminars,
      "evaluationBoards": evaluationBoards,
    };
  }
}
