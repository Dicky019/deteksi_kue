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
    return PrediksiKueModel(
      predicted: map['predicted'] ?? false,
      predictedClass: map['predicted_class'] ?? "...",
      confidenceScore: map['confidenceScore'] ?? "...",
      image: image,
    );
  }
}
