import 'package:equatable/equatable.dart';

sealed class LoaderState extends Equatable {
  const LoaderState();

  @override
  List<Object> get props => [];
}

final class LoaderInitial extends LoaderState {}

final class LoaderStartSuccess extends LoaderState {}

final class LoaderStopSuccess extends LoaderState {}