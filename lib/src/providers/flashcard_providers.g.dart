// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flashcard_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getFlashcardByIdHash() => r'46396b1805f7063defae00ace3af599cf8743b14';

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

typedef GetFlashcardByIdRef = AutoDisposeFutureProviderRef<Flashcard>;

/// See also [getFlashcardById].
@ProviderFor(getFlashcardById)
const getFlashcardByIdProvider = GetFlashcardByIdFamily();

/// See also [getFlashcardById].
class GetFlashcardByIdFamily extends Family<AsyncValue<Flashcard>> {
  /// See also [getFlashcardById].
  const GetFlashcardByIdFamily();

  /// See also [getFlashcardById].
  GetFlashcardByIdProvider call(
    String flashcardId,
  ) {
    return GetFlashcardByIdProvider(
      flashcardId,
    );
  }

  @override
  GetFlashcardByIdProvider getProviderOverride(
    covariant GetFlashcardByIdProvider provider,
  ) {
    return call(
      provider.flashcardId,
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
  String? get name => r'getFlashcardByIdProvider';
}

/// See also [getFlashcardById].
class GetFlashcardByIdProvider extends AutoDisposeFutureProvider<Flashcard> {
  /// See also [getFlashcardById].
  GetFlashcardByIdProvider(
    this.flashcardId,
  ) : super.internal(
          (ref) => getFlashcardById(
            ref,
            flashcardId,
          ),
          from: getFlashcardByIdProvider,
          name: r'getFlashcardByIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getFlashcardByIdHash,
          dependencies: GetFlashcardByIdFamily._dependencies,
          allTransitiveDependencies:
              GetFlashcardByIdFamily._allTransitiveDependencies,
        );

  final String flashcardId;

  @override
  bool operator ==(Object other) {
    return other is GetFlashcardByIdProvider &&
        other.flashcardId == flashcardId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, flashcardId.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
