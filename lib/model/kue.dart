// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:faker/faker.dart';

class Kue {
  final String title;
  final String minides;
  final String image;
  final String markdownData;

  const Kue({
    required this.title,
    required this.minides,
    required this.image,
    required this.markdownData,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'minides': minides,
      'image': image,
      'markdownData': markdownData,
    };
  }

  factory Kue.fromMap(Map<String, dynamic> map) {
    return Kue(
      title: map['title'] as String,
      minides: map['minides'] as String,
      image: map['image'] as String,
      markdownData: map['markdownData'] as String,
    );
  }

  factory Kue.faker() {
    return Kue(
      title: faker.food.cuisine(),
      minides: faker.lorem.sentence(),
      image: 'https://deteksi-kue-api.vercel.app/onde_onde.jpg',
      markdownData: """
# Minimal Markdown Test
---
This is a simple Markdown test. Provide a text string with Markdown tags
to the Markdown widget and it will display the formatted output in a
scrollable widget.
## Section 1
Maecenas eget **arcu egestas**, mollis ex vitae, posuere magna. Nunc eget
aliquam tortor. Vestibulum porta sodales efficitur. Mauris interdum turpis
eget est condimentum, vitae porttitor diam ornare.
### Subsection A
Sed et massa finibus, blandit massa vel, vulputate velit. Vestibulum vitae
venenatis libero. **__Curabitur sem lectus, feugiat eu justo in, eleifend
accumsan ante.__** Sed a fermentum elit. Curabitur sodales metus id mi
ornare, in ullamcorper magna congue.
""",
    );
  }

  String toJson() => json.encode(toMap());

  factory Kue.fromJson(String source) =>
      Kue.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Kue(title: $title, minides: $minides, image: $image)';
  }
}

class Kues {
  final List<Kue> values;

  const Kues({
    required this.values,
  });

  Kues copyWith({
    List<Kue>? values,
  }) {
    return Kues(
      values: values ?? this.values,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'values': values.map((x) => x.toMap()).toList(),
    };
  }

  factory Kues.fromMap(List<dynamic> list) {
    return Kues(
      values: list
          .map(
            (x) => Kue.fromMap(x as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  factory Kues.faker(int number) {
    return Kues(
      values: List<Kue>.generate(
        number,
        (index) => Kue.faker(),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Kues.fromJson(String source) =>
      Kues.fromMap(json.decode(source) as List<dynamic>);

  @override
  String toString() => 'Kues(values: $values)';
}
