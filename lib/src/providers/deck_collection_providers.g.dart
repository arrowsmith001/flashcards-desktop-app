// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deck_collection_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$addDeckCollectionHash() => r'08b159ab5211b13ad699184ba3e4705e929b4a58';

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

typedef AddDeckCollectionRef = AutoDisposeFutureProviderRef<DeckCollection>;

/// See also [addDeckCollection].
@ProviderFor(addDeckCollection)
const addDeckCollectionProvider = AddDeckCollectionFamily();

/// See also [addDeckCollection].
class AddDeckCollectionFamily extends Family<AsyncValue<DeckCollection>> {
  /// See also [addDeckCollection].
  const AddDeckCollectionFamily();

  /// See also [addDeckCollection].
  AddDeckCollectionProvider call(
    DeckCollection deckCollection,
  ) {
    return AddDeckCollectionProvider(
      deckCollection,
    );
  }

  @override
  AddDeckCollectionProvider getProviderOverride(
    covariant AddDeckCollectionProvider provider,
  ) {
    return call(
      provider.deckCollection,
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
  String? get name => r'addDeckCollectionProvider';
}

/// See also [addDeckCollection].
class AddDeckCollectionProvider
    extends AutoDisposeFutureProvider<DeckCollection> {
  /// See also [addDeckCollection].
  AddDeckCollectionProvider(
    this.deckCollection,
  ) : super.internal(
          (ref) => addDeckCollection(
            ref,
            deckCollection,
          ),
          from: addDeckCollectionProvider,
          name: r'addDeckCollectionProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$addDeckCollectionHash,
          dependencies: AddDeckCollectionFamily._dependencies,
          allTransitiveDependencies:
              AddDeckCollectionFamily._allTransitiveDependencies,
        );

  final DeckCollection deckCollection;

  @override
  bool operator ==(Object other) {
    return other is AddDeckCollectionProvider &&
        other.deckCollection == deckCollection;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, deckCollection.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$getAllDeckCollectionsHash() =>
    r'06c86f9c5bc6d908326e8ef56353b5e05093967a';

/// See also [getAllDeckCollections].
@ProviderFor(getAllDeckCollections)
final getAllDeckCollectionsProvider =
    AutoDisposeFutureProvider<List<DeckCollection>>.internal(
  getAllDeckCollections,
  name: r'getAllDeckCollectionsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getAllDeckCollectionsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetAllDeckCollectionsRef
    = AutoDisposeFutureProviderRef<List<DeckCollection>>;
String _$getDeckCollectionsByIdsHash() =>
    r'ccc1e2f5e0dd1d94a4a2cad05ae22ccce459d518';
typedef GetDeckCollectionsByIdsRef
    = AutoDisposeFutureProviderRef<List<DeckCollection>>;

/// See also [getDeckCollectionsByIds].
@ProviderFor(getDeckCollectionsByIds)
const getDeckCollectionsByIdsProvider = GetDeckCollectionsByIdsFamily();

/// See also [getDeckCollectionsByIds].
class GetDeckCollectionsByIdsFamily
    extends Family<AsyncValue<List<DeckCollection>>> {
  /// See also [getDeckCollectionsByIds].
  const GetDeckCollectionsByIdsFamily();

  /// See also [getDeckCollectionsByIds].
  GetDeckCollectionsByIdsProvider call(
    List<String> ids,
  ) {
    return GetDeckCollectionsByIdsProvider(
      ids,
    );
  }

  @override
  GetDeckCollectionsByIdsProvider getProviderOverride(
    covariant GetDeckCollectionsByIdsProvider provider,
  ) {
    return call(
      provider.ids,
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
  String? get name => r'getDeckCollectionsByIdsProvider';
}

/// See also [getDeckCollectionsByIds].
class GetDeckCollectionsByIdsProvider
    extends AutoDisposeFutureProvider<List<DeckCollection>> {
  /// See also [getDeckCollectionsByIds].
  GetDeckCollectionsByIdsProvider(
    this.ids,
  ) : super.internal(
          (ref) => getDeckCollectionsByIds(
            ref,
            ids,
          ),
          from: getDeckCollectionsByIdsProvider,
          name: r'getDeckCollectionsByIdsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getDeckCollectionsByIdsHash,
          dependencies: GetDeckCollectionsByIdsFamily._dependencies,
          allTransitiveDependencies:
              GetDeckCollectionsByIdsFamily._allTransitiveDependencies,
        );

  final List<String> ids;

  @override
  bool operator ==(Object other) {
    return other is GetDeckCollectionsByIdsProvider && other.ids == ids;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, ids.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$getDeckCollectionByIdHash() =>
    r'7ff5484fd0490bdf60aaaac0c61a9bd179629e6a';
typedef GetDeckCollectionByIdRef = AutoDisposeFutureProviderRef<DeckCollection>;

/// See also [getDeckCollectionById].
@ProviderFor(getDeckCollectionById)
const getDeckCollectionByIdProvider = GetDeckCollectionByIdFamily();

/// See also [getDeckCollectionById].
class GetDeckCollectionByIdFamily extends Family<AsyncValue<DeckCollection>> {
  /// See also [getDeckCollectionById].
  const GetDeckCollectionByIdFamily();

  /// See also [getDeckCollectionById].
  GetDeckCollectionByIdProvider call(
    String id,
  ) {
    return GetDeckCollectionByIdProvider(
      id,
    );
  }

  @override
  GetDeckCollectionByIdProvider getProviderOverride(
    covariant GetDeckCollectionByIdProvider provider,
  ) {
    return call(
      provider.id,
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
  String? get name => r'getDeckCollectionByIdProvider';
}

/// See also [getDeckCollectionById].
class GetDeckCollectionByIdProvider
    extends AutoDisposeFutureProvider<DeckCollection> {
  /// See also [getDeckCollectionById].
  GetDeckCollectionByIdProvider(
    this.id,
  ) : super.internal(
          (ref) => getDeckCollectionById(
            ref,
            id,
          ),
          from: getDeckCollectionByIdProvider,
          name: r'getDeckCollectionByIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getDeckCollectionByIdHash,
          dependencies: GetDeckCollectionByIdFamily._dependencies,
          allTransitiveDependencies:
              GetDeckCollectionByIdFamily._allTransitiveDependencies,
        );

  final String id;

  @override
  bool operator ==(Object other) {
    return other is GetDeckCollectionByIdProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$deleteDeckCollectionHash() =>
    r'3745a4e2f6582f2880e500e705af18d725090f11';
typedef DeleteDeckCollectionRef = AutoDisposeFutureProviderRef<void>;

/// See also [deleteDeckCollection].
@ProviderFor(deleteDeckCollection)
const deleteDeckCollectionProvider = DeleteDeckCollectionFamily();

/// See also [deleteDeckCollection].
class DeleteDeckCollectionFamily extends Family<AsyncValue<void>> {
  /// See also [deleteDeckCollection].
  const DeleteDeckCollectionFamily();

  /// See also [deleteDeckCollection].
  DeleteDeckCollectionProvider call(
    String deckCollectionId,
  ) {
    return DeleteDeckCollectionProvider(
      deckCollectionId,
    );
  }

  @override
  DeleteDeckCollectionProvider getProviderOverride(
    covariant DeleteDeckCollectionProvider provider,
  ) {
    return call(
      provider.deckCollectionId,
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
  String? get name => r'deleteDeckCollectionProvider';
}

/// See also [deleteDeckCollection].
class DeleteDeckCollectionProvider extends AutoDisposeFutureProvider<void> {
  /// See also [deleteDeckCollection].
  DeleteDeckCollectionProvider(
    this.deckCollectionId,
  ) : super.internal(
          (ref) => deleteDeckCollection(
            ref,
            deckCollectionId,
          ),
          from: deleteDeckCollectionProvider,
          name: r'deleteDeckCollectionProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$deleteDeckCollectionHash,
          dependencies: DeleteDeckCollectionFamily._dependencies,
          allTransitiveDependencies:
              DeleteDeckCollectionFamily._allTransitiveDependencies,
        );

  final String deckCollectionId;

  @override
  bool operator ==(Object other) {
    return other is DeleteDeckCollectionProvider &&
        other.deckCollectionId == deckCollectionId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, deckCollectionId.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$addDeckAndAddToCollectionHash() =>
    r'ee6642f248dc6372b4d08615d3ac488f96bc5833';
typedef AddDeckAndAddToCollectionRef = AutoDisposeFutureProviderRef<void>;

/// See also [addDeckAndAddToCollection].
@ProviderFor(addDeckAndAddToCollection)
const addDeckAndAddToCollectionProvider = AddDeckAndAddToCollectionFamily();

/// See also [addDeckAndAddToCollection].
class AddDeckAndAddToCollectionFamily extends Family<AsyncValue<void>> {
  /// See also [addDeckAndAddToCollection].
  const AddDeckAndAddToCollectionFamily();

  /// See also [addDeckAndAddToCollection].
  AddDeckAndAddToCollectionProvider call(
    Deck deck,
    DeckCollection deckCollection,
    String path,
  ) {
    return AddDeckAndAddToCollectionProvider(
      deck,
      deckCollection,
      path,
    );
  }

  @override
  AddDeckAndAddToCollectionProvider getProviderOverride(
    covariant AddDeckAndAddToCollectionProvider provider,
  ) {
    return call(
      provider.deck,
      provider.deckCollection,
      provider.path,
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
  String? get name => r'addDeckAndAddToCollectionProvider';
}

/// See also [addDeckAndAddToCollection].
class AddDeckAndAddToCollectionProvider
    extends AutoDisposeFutureProvider<void> {
  /// See also [addDeckAndAddToCollection].
  AddDeckAndAddToCollectionProvider(
    this.deck,
    this.deckCollection,
    this.path,
  ) : super.internal(
          (ref) => addDeckAndAddToCollection(
            ref,
            deck,
            deckCollection,
            path,
          ),
          from: addDeckAndAddToCollectionProvider,
          name: r'addDeckAndAddToCollectionProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$addDeckAndAddToCollectionHash,
          dependencies: AddDeckAndAddToCollectionFamily._dependencies,
          allTransitiveDependencies:
              AddDeckAndAddToCollectionFamily._allTransitiveDependencies,
        );

  final Deck deck;
  final DeckCollection deckCollection;
  final String path;

  @override
  bool operator ==(Object other) {
    return other is AddDeckAndAddToCollectionProvider &&
        other.deck == deck &&
        other.deckCollection == deckCollection &&
        other.path == path;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, deck.hashCode);
    hash = _SystemHash.combine(hash, deckCollection.hashCode);
    hash = _SystemHash.combine(hash, path.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$getFakeDeckCollectionHash() =>
    r'77b74cb12805db88daaefbe6f4e2d38392dc3cff';

/// See also [getFakeDeckCollection].
@ProviderFor(getFakeDeckCollection)
final getFakeDeckCollectionProvider =
    AutoDisposeProvider<DeckCollection>.internal(
  getFakeDeckCollection,
  name: r'getFakeDeckCollectionProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getFakeDeckCollectionHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetFakeDeckCollectionRef = AutoDisposeProviderRef<DeckCollection>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
