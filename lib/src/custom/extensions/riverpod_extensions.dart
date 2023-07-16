
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension RiverpodExtensions<T> on AsyncValue<T> {
  R whenDefault<R>(
      {bool skipLoadingOnReload = false,
      bool skipLoadingOnRefresh = true,
      bool skipError = false,
      required R Function(T) data}) {
    return when<R>(skipLoadingOnReload: skipLoadingOnReload, skipLoadingOnRefresh: skipLoadingOnRefresh, skipError: skipError,
      data: data, error: (e,_) => Text(e.toString()) as R, loading: () => CircularProgressIndicator() as R);
  }
}
