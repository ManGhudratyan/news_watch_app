import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';

part 'connectivity_state.dart';

class ConnectivityCubit extends Cubit<ConnectivityState> {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<List<ConnectivityResult>>? _subscription;

  ConnectivityCubit() : super(ConnectivityInitial()) {
    _init();
  }

  Future<void> _init() async {
    final List<ConnectivityResult> results = await _connectivity
        .checkConnectivity();
    _updateStatus(results);

    _subscription = _connectivity.onConnectivityChanged.listen((
      List<ConnectivityResult> results,
    ) {
      _updateStatus(results);
    });
  }

  void _updateStatus(List<ConnectivityResult> results) {
    final bool isDisconnected =
        results.isEmpty || results.contains(ConnectivityResult.none);

    if (isDisconnected) {
      emit(ConnectivityDisconnected());
    } else {
      emit(ConnectivityConnected());
    }
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
