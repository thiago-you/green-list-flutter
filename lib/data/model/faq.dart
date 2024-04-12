class Faq {
  int? id;
  String? question;
  String? answer;
  String? image;
  String? imageAlt;
  String? thumbnail;

  Faq({
    this.id,
    this.question,
    this.answer,
    this.image,
    this.imageAlt,
    this.thumbnail
  });

  Faq.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    answer = json['answer'];
    image = json['default_image']?['original_url'] ?? "";
    imageAlt = json['default_image']?['regular_url'] ?? "";
    thumbnail = json['default_image']?['medium_url'] ?? "";
  }

  @override
  String toString() {
    return 'FAQ{id: $id, question: $question, answer: $answer, image: $image, imageAlt: $imageAlt, thumbnail: $thumbnail}';
  }
}