import 'dart:io';

// return {
//     'predicted' : True,
//     'predicted_class' : predicted_class_result,
//     'confidence_score' : confidence_score_result
// }

class PrediksiKueModel {
  final bool predicted;
  final String predictedClass;
  final String confidenceScore;
  final File image;

  PrediksiKueModel({
    required this.predicted,
    required this.predictedClass,
    required this.confidenceScore,
    required this.image,
  });

  bool get isBukanKue => predicted == true;

  factory PrediksiKueModel.fromResult(
    Map<String, dynamic> map,
    File image,
  ) {
    final predicted = (map['predicted'] ?? "...") as bool;
    final predictedClass = (map['predicted_class'] ?? "...") as String;
    final confidenceScore = (map['confidence_score'] ?? "...") as String;

    final predictedClassJson = predictedClass == "kue_onde"
        ? "Kue Onde-Onde"
        : predictedClass
            .split("_")
            .map((predicted) => predicted.toUpperCase())
            .join(" ");

    return PrediksiKueModel(
      predicted: predicted,
      predictedClass: predictedClassJson,
      confidenceScore: confidenceScore,
      image: image,
    );
  }
}
