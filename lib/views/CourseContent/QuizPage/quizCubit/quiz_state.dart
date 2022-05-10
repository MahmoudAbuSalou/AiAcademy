part of 'quiz_cubit.dart';

@immutable
abstract class QuizState {}

class QuizInitial extends QuizState {}
class GetQuizLoading extends QuizState {}
class GetQuizSuccess extends QuizState {}
class GetQuizError extends QuizState {}
class chgScreenQuiz extends QuizState {}
class changeState extends QuizState {}
class loadingQuiz extends QuizState {}
class loadingFinishQuiz extends QuizState {}
class StartQuizSuccess extends QuizState {}
class FinishQuizSuccess extends QuizState {}
class StartQuizFailed extends QuizState {}
class FinishQuizFailed extends QuizState {}
class ChangeTime extends QuizState {}
