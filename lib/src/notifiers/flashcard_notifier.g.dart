// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flashcard_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$flashcardNotifierHash() => r'd459e02ec17925de17cb99c5537ed50c8444232b';

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

abstract class _$FlashcardNotifier extends BuildlessAsyncNotifier<Flashcard> {
  late final String arg;

  FutureOr<Flashcard> build(
    String arg,
  );
}

/// See also [FlashcardNotifier].
@ProviderFor(FlashcardNotifier)
const flashcardNotifierProvider = FlashcardNotifierFamily();

/// See also [FlashcardNotifier].
class FlashcardNotifierFamily extends Family<AsyncValue<Flashcard>> {
  /// See also [FlashcardNotifier].
  const FlashcardNotifierFamily();

  /// See also [FlashcardNotifier].
  FlashcardNotifierProvider call(
    String arg,
  ) {
    return FlashcardNotifierProvider(
      arg,
    );
  }

  @override
  FlashcardNotifierProvider getProviderOverride(
    covariant FlashcardNotifierProvider provider,
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
  String? get name => r'flashcardNotifierProvider';
}

/// See also [FlashcardNotifier].
class FlashcardNotifierProvider
    extends AsyncNotifierProviderImpl<FlashcardNotifier, Flashcard> {
  /// See also [FlashcardNotifier].
  FlashcardNotifierProvider(
    this.arg,
  ) : super.internal(
          () => FlashcardNotifier()..arg = arg,
          from: flashcardNotifierProvider,
          name: r'flashcardNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$flashcardNotifierHash,
          dependencies: FlashcardNotifierFamily._dependencies,
          allTransitiveDependencies:
              FlashcardNotifierFamily._allTransitiveDependencies,
        );

  final String arg;

  @override
  bool operator ==(Object other) {
    return other is FlashcardNotifierProvider && other.arg == arg;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, arg.hashCode);

    return _SystemHash.finish(hash);
  }

  @override
  FutureOr<Flashcard> runNotifierBuild(
    covariant FlashcardNotifier notifier,
  ) {
    return notifier.build(
      arg,
    );
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
