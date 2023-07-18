// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'study_session_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$studySessionNotifierHash() =>
    r'2c65a43aa0fe2c76e1695d6f60df9cd1f1cffc9b';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$StudySessionNotifier
    extends BuildlessAsyncNotifier<StudySession> {
  late final List<String> arg;

  FutureOr<StudySession> build(
    List<String> arg,
  );
}

/// See also [StudySessionNotifier].
@ProviderFor(StudySessionNotifier)
const studySessionNotifierProvider = StudySessionNotifierFamily();

/// See also [StudySessionNotifier].
class StudySessionNotifierFamily extends Family<AsyncValue<StudySession>> {
  /// See also [StudySessionNotifier].
  const StudySessionNotifierFamily();

  /// See also [StudySessionNotifier].
  StudySessionNotifierProvider call(
    List<String> arg,
  ) {
    return StudySessionNotifierProvider(
      arg,
    );
  }

  @override
  StudySessionNotifierProvider getProviderOverride(
    covariant StudySessionNotifierProvider provider,
  ) {
    return call(
      provider.arg,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'studySessionNotifierProvider';
}

/// See also [StudySessionNotifier].
class StudySessionNotifierProvider
    extends AsyncNotifierProviderImpl<StudySessionNotifier, StudySession> {
  /// See also [StudySessionNotifier].
  StudySessionNotifierProvider(
    this.arg,
  ) : super.internal(
          () => StudySessionNotifier()..arg = arg,
          from: studySessionNotifierProvider,
          name: r'studySessionNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$studySessionNotifierHash,
          dependencies: StudySessionNotifierFamily._dependencies,
          allTransitiveDependencies:
              StudySessionNotifierFamily._allTransitiveDependencies,
        );

  final List<String> arg;

  @override
  bool operator ==(Object other) {
    return other is StudySessionNotifierProvider && other.arg == arg;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, arg.hashCode);

    return _SystemHash.finish(hash);
  }

  @override
  FutureOr<StudySession> runNotifierBuild(
    covariant StudySessionNotifier notifier,
  ) {
    return notifier.build(
      arg,
    );
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
