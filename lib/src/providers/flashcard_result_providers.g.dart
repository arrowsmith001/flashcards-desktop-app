// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flashcard_result_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getFlashcardResultByIdHash() =>
    r'47491010ca52f9c80ce45ba00f35fa453f6fd603';

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

typedef GetFlashcardResultByIdRef
    = AutoDisposeFutureProviderRef<FlashcardResult>;

/// See also [getFlashcardResultById].
@ProviderFor(getFlashcardResultById)
const getFlashcardResultByIdProvider = GetFlashcardResultByIdFamily();

/// See also [getFlashcardResultById].
class GetFlashcardResultByIdFamily extends Family<AsyncValue<FlashcardResult>> {
  /// See also [getFlashcardResultById].
  const GetFlashcardResultByIdFamily();

  /// See also [getFlashcardResultById].
  GetFlashcardResultByIdProvider call(
    String flashcardResultId,
  ) {
    return GetFlashcardResultByIdProvider(
      flashcardResultId,
    );
  }

  @override
  GetFlashcardResultByIdProvider getProviderOverride(
    covariant GetFlashcardResultByIdProvider provider,
  ) {
    return call(
      provider.flashcardResultId,
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
  String? get name => r'getFlashcardResultByIdProvider';
}

/// See also [getFlashcardResultById].
class GetFlashcardResultByIdProvider
    extends AutoDisposeFutureProvider<FlashcardResult> {
  /// See also [getFlashcardResultById].
  GetFlashcardResultByIdProvider(
    this.flashcardResultId,
  ) : super.internal(
          (ref) => getFlashcardResultById(
            ref,
            flashcardResultId,
          ),
          from: getFlashcardResultByIdProvider,
          name: r'getFlashcardResultByIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getFlashcardResultByIdHash,
          dependencies: GetFlashcardResultByIdFamily._dependencies,
          allTransitiveDependencies:
              GetFlashcardResultByIdFamily._allTransitiveDependencies,
        );

  final String flashcardResultId;

  @override
  bool operator ==(Object other) {
    return other is GetFlashcardResultByIdProvider &&
        other.flashcardResultId == flashcardResultId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, flashcardResultId.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
