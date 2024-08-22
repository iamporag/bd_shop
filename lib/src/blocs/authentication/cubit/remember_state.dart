part of 'remember_cubit.dart';

@immutable
sealed class RememberState {}

final class RememberInitial extends RememberState {}

final class SwitchStatusChange extends RememberState{
  final bool value;

   SwitchStatusChange(
    this.value
    );
}
