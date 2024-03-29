import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

typedef BroadcastObserver = void Function(Map<String, dynamic> data);

class Broadcast extends Equatable {
  final Key blocKey;
  final String event;
  final BroadcastObserver? onNext;

  Broadcast({
    required this.blocKey,
    required this.event,
    this.onNext,
  });

  @override
  List<Object> get props => [blocKey];
}
