// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deck_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$deckNotifierHash() => r'22f14ac5a04b42b77b4e0ce73d5458f95acedd77';

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

abstract class _$DeckNotifier extends BuildlessAsyncNotifier<Deck> {
  late final String arg;

  FutureOr<Deck> build(
    String arg,
  );
}

/// See also [DeckNotifier].
@ProviderFor(DeckNotifier)
const deckNotifierProvider = DeckNotifierFamily();

/// See also [DeckNotifier].
class DeckNotifierFamily extends Family<AsyncValue<Deck>> {
  /// See also [DeckNotifier].
  const DeckNotifierFamily();

  /// See also [DeckNotifier].
  DeckNotifierProvider call(
    String arg,
  ) {
    return DeckNotifierProvider(
      arg,
    );
  }

  @override
  DeckNotifierProvider getProviderOverride(
    covariant DeckNotifierProvider provider,
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
  String? get name => r'deckNotifierProvider';
}

/// See also [DeckNotifier].
class DeckNotifierProvider
    extends AsyncNotifierProviderImpl<DeckNotifier, Deck> {
  /// See also [DeckNotifier].
  DeckNotifierProvider(
    this.arg,
  ) : super.internal(
          () => DeckNotifier()..arg = arg,
          from: deckNotifierProvider,
          name: r'deckNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$deckNotifierHash,
          dependencies: DeckNotifierFamily._dependencies,
          allTransitiveDependencies:
              DeckNotifierFamily._allTransitiveDependencies,
        );

  final String arg;

  @override
  bool operator ==(Object other) {
    return other is DeckNotifierProvider && other.arg == arg;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, arg.hashCode);

    return _SystemHash.finish(hash);
  }

  @override
  FutureOr<Deck> runNotifierBuild(
    covariant DeckNotifier notifier,
  ) {
    return notifier.build(
      arg,
    );
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
