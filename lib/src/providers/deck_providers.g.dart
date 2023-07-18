// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deck_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getDecksByIdsHash() => r'e55cfc340d655c0342bec564ef39c3f9794a7e68';

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

typedef GetDecksByIdsRef = AutoDisposeFutureProviderRef<List<Deck>>;

/// See also [getDecksByIds].
@ProviderFor(getDecksByIds)
const getDecksByIdsProvider = GetDecksByIdsFamily();

/// See also [getDecksByIds].
class GetDecksByIdsFamily extends Family<AsyncValue<List<Deck>>> {
  /// See also [getDecksByIds].
  const GetDecksByIdsFamily();

  /// See also [getDecksByIds].
  GetDecksByIdsProvider call(
    List<String> deckIds,
  ) {
    return GetDecksByIdsProvider(
      deckIds,
    );
  }

  @override
  GetDecksByIdsProvider getProviderOverride(
    covariant GetDecksByIdsProvider provider,
  ) {
    return call(
      provider.deckIds,
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
  String? get name => r'getDecksByIdsProvider';
}

/// See also [getDecksByIds].
class GetDecksByIdsProvider extends AutoDisposeFutureProvider<List<Deck>> {
  /// See also [getDecksByIds].
  GetDecksByIdsProvider(
    this.deckIds,
  ) : super.internal(
          (ref) => getDecksByIds(
            ref,
            deckIds,
          ),
          from: getDecksByIdsProvider,
          name: r'getDecksByIdsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getDecksByIdsHash,
          dependencies: GetDecksByIdsFamily._dependencies,
          allTransitiveDependencies:
              GetDecksByIdsFamily._allTransitiveDependencies,
        );

  final List<String> deckIds;

  @override
  bool operator ==(Object other) {
    return other is GetDecksByIdsProvider && other.deckIds == deckIds;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, deckIds.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$getDeckByIdHash() => r'c19a010365ed5e4b9358fd3725d93529b467f493';
typedef GetDeckByIdRef = AutoDisposeFutureProviderRef<Deck>;

/// See also [getDeckById].
@ProviderFor(getDeckById)
const getDeckByIdProvider = GetDeckByIdFamily();

/// See also [getDeckById].
class GetDeckByIdFamily extends Family<AsyncValue<Deck>> {
  /// See also [getDeckById].
  const GetDeckByIdFamily();

  /// See also [getDeckById].
  GetDeckByIdProvider call(
    String deckId,
  ) {
    return GetDeckByIdProvider(
      deckId,
    );
  }

  @override
  GetDeckByIdProvider getProviderOverride(
    covariant GetDeckByIdProvider provider,
  ) {
    return call(
      provider.deckId,
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
  String? get name => r'getDeckByIdProvider';
}

/// See also [getDeckById].
class GetDeckByIdProvider extends AutoDisposeFutureProvider<Deck> {
  /// See also [getDeckById].
  GetDeckByIdProvider(
    this.deckId,
  ) : super.internal(
          (ref) => getDeckById(
            ref,
            deckId,
          ),
          from: getDeckByIdProvider,
          name: r'getDeckByIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getDeckByIdHash,
          dependencies: GetDeckByIdFamily._dependencies,
          allTransitiveDependencies:
              GetDeckByIdFamily._allTransitiveDependencies,
        );

  final String deckId;

  @override
  bool operator ==(Object other) {
    return other is GetDeckByIdProvider && other.deckId == deckId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, deckId.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
