import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hand_bill/src/data/model/user.dart';
import 'package:hand_bill/src/repositories/global_repository.dart';

part 'global_event.dart';

part 'global_state.dart';

class GlobalBloc extends Bloc<GlobalEvent, GlobalState> {
  User? user;
  final GlobalRepository globalRepository = GlobalRepository();

  GlobalBloc() : super(GlobalInitial());

  @override
  Stream<GlobalState> mapEventToState(
    GlobalEvent event,
  ) async* {
    if (event is StartAppEvent) {
      yield* _mapStartAppToState(event);
    }
    if (event is UserStatusChangeEvent) {
      yield* _mapUserStatusChangeToState(event);
    }
  }

  Stream<GlobalState> _mapStartAppToState(StartAppEvent event) async* {
    yield GlobalLoading();
    User? _user;
    _user = await globalRepository.getCurrentUser();
    if (_user == null) {
      user = null;
    } else {
      user = _user;
      log("token ${user!.apiToken}");
    }
    yield StartAppSuccess(user: _user);
  }

  Stream<GlobalState> _mapUserStatusChangeToState(
      UserStatusChangeEvent event) async* {
    yield GlobalLoading();
    User? _user = await globalRepository.getCurrentUser();
    if (_user == null) {
      user = null;
      yield UserStatusChangeSuccess();
    } else {
      user = _user;
      yield UserStatusChangeSuccess();
    }
  }
}
