class QuestionReview {
  final int id;
  final String questionText;
  final String option1;
  final String option2;
  final String option3;
  final String option4;
  final String option5;
  final String selectRange;
  final String questionType;

  QuestionReview(
      this.id,
      this.questionText,
      this.option1,
      this.option2,
      this.option3,
      this.option4,
      this.option5,
      this.selectRange,
      this.questionType);

  QuestionReview.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        questionText = json["questionText"],
        option1 = json["option1"],
        option2 = json["option2"],
        option3 = json["option3"],
        option4 = json["option4"],
        option5 = json["option5"],
        selectRange = json["selectRange"],
        questionType = json["questionType"];
}
