import 'package:equatable/equatable.dart';

class Notes extends Equatable {

  final String title;
  final String descriptions;
  final bool isFinish;

  const Notes(this.title, this.descriptions, this.isFinish);

  @override
  List<Object?> get props => [title, descriptions, isFinish];
}