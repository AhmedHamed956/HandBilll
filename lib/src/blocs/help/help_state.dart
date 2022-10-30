import 'package:equatable/equatable.dart';
import 'package:hand_bill/src/data/model/account_package/agent_model.dart';

abstract class HelpState extends Equatable {
  const HelpState();

  @override
  List<Object> get props => [];
}

class HelpInitialState extends HelpState {}

class HelpLoadingState extends HelpState {}

class HelpErrorState extends HelpState {
  final String? error;

  HelpErrorState({required this.error});
}

// fetch
class AgentSuccessState extends HelpState {
  final List<AgentModel>? items;

  AgentSuccessState({required this.items});
}
