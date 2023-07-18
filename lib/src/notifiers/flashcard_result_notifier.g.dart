// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flashcard_result_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$flashcardResultNotifierHash() =>
    r'5d5bb65d34b1cb818722e068ecbd55ee4f4c5f79';

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

abstract class _$FlashcardResultNotifier
    extends BuildlessAsyncNotifier<FlashcardResult> {
  late final String arg;

  FutureOr<FlashcardResult> build(
    String arg,
  );
}

/// See also [FlashcardResultNotifier].
@ProviderFor(FlashcardResultNotifier)
const flashcardResultNotifierProvider = FlashcardResultNotifierFamily();

/// See also [FlashcardResultNotifier].
class FlashcardResultNotifierFamily
    extends Family<AsyncValue<FlashcardResult>> {
  /// See also [FlashcardResultNotifier].
  const FlashcardResultNotifierFamily();

  /// See also [FlashcardResultNotifier].
  FlashcardResultNotifierProvider call(
    String arg,
  ) {
    return FlashcardResultNotifierProvider(
      arg,
    );
  }

  @override
  FlashcardResultNotifierProvider getProviderOverride(
    covariant FlashcardResultNotifierProvider provider,
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
  String? get name => r'flashcardResultNotifierProvider';
}

/// See also [FlashcardResultNotifier].
class FlashcardResultNotifierProvider extends AsyncNotifierProviderImpl<
    FlashcardResultNotifier, FlashcardResult> {
  /// See also [FlashcardResultNotifier].
  FlashcardResultNotifierProvider(
    this.arg,
  ) : super.internal(
          () => FlashcardResultNotifier()..arg = arg,
          from: flashcardResultNotifierProvider,
          name: r'flashcardResultNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$flashcardResultNotifierHash,
          dependencies: FlashcardResultNotifierFamily._dependencies,
          allTransitiveDependencies:
              FlashcardResultNotifierFamily._allTransitiveDependencies,
        );

  final String arg;

  @override
  bool operator ==(Object other) {
    return other is FlashcardResultNotifierProvider && other.arg == arg;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, arg.hashCode);

    return _SystemHash.finish(hash);
  }

  @override
  FutureOr<FlashcardResult> runNotifierBuild(
    covariant FlashcardResultNotifier notifier,
  ) {
    return notifier.build(
      arg,
    );
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
