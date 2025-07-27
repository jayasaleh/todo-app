// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firestore_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$firestoreRepositoryHash() =>
    r'0e8d2df1d21e116228f369461d7e8306873b6013';

/// See also [firestoreRepository].
@ProviderFor(firestoreRepository)
final firestoreRepositoryProvider = Provider<FirestoreRepository>.internal(
  firestoreRepository,
  name: r'firestoreRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$firestoreRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FirestoreRepositoryRef = ProviderRef<FirestoreRepository>;
String _$loadTasksHash() => r'c79a34959b84cb807ae456feb57def5c6db0ef4d';

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

/// See also [loadTasks].
@ProviderFor(loadTasks)
const loadTasksProvider = LoadTasksFamily();

/// See also [loadTasks].
class LoadTasksFamily extends Family<AsyncValue<List<Task>>> {
  /// See also [loadTasks].
  const LoadTasksFamily();

  /// See also [loadTasks].
  LoadTasksProvider call(String userId) {
    return LoadTasksProvider(userId);
  }

  @override
  LoadTasksProvider getProviderOverride(covariant LoadTasksProvider provider) {
    return call(provider.userId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'loadTasksProvider';
}

/// See also [loadTasks].
class LoadTasksProvider extends AutoDisposeStreamProvider<List<Task>> {
  /// See also [loadTasks].
  LoadTasksProvider(String userId)
    : this._internal(
        (ref) => loadTasks(ref as LoadTasksRef, userId),
        from: loadTasksProvider,
        name: r'loadTasksProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$loadTasksHash,
        dependencies: LoadTasksFamily._dependencies,
        allTransitiveDependencies: LoadTasksFamily._allTransitiveDependencies,
        userId: userId,
      );

  LoadTasksProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
  }) : super.internal();

  final String userId;

  @override
  Override overrideWith(
    Stream<List<Task>> Function(LoadTasksRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: LoadTasksProvider._internal(
        (ref) => create(ref as LoadTasksRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<Task>> createElement() {
    return _LoadTasksProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LoadTasksProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin LoadTasksRef on AutoDisposeStreamProviderRef<List<Task>> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _LoadTasksProviderElement
    extends AutoDisposeStreamProviderElement<List<Task>>
    with LoadTasksRef {
  _LoadTasksProviderElement(super.provider);

  @override
  String get userId => (origin as LoadTasksProvider).userId;
}

String _$loadCompletedTasksHash() =>
    r'7078121020a0a9aa562855455b7c5d18533027fd';

/// See also [loadCompletedTasks].
@ProviderFor(loadCompletedTasks)
const loadCompletedTasksProvider = LoadCompletedTasksFamily();

/// See also [loadCompletedTasks].
class LoadCompletedTasksFamily extends Family<AsyncValue<List<Task>>> {
  /// See also [loadCompletedTasks].
  const LoadCompletedTasksFamily();

  /// See also [loadCompletedTasks].
  LoadCompletedTasksProvider call(String userId) {
    return LoadCompletedTasksProvider(userId);
  }

  @override
  LoadCompletedTasksProvider getProviderOverride(
    covariant LoadCompletedTasksProvider provider,
  ) {
    return call(provider.userId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'loadCompletedTasksProvider';
}

/// See also [loadCompletedTasks].
class LoadCompletedTasksProvider extends AutoDisposeStreamProvider<List<Task>> {
  /// See also [loadCompletedTasks].
  LoadCompletedTasksProvider(String userId)
    : this._internal(
        (ref) => loadCompletedTasks(ref as LoadCompletedTasksRef, userId),
        from: loadCompletedTasksProvider,
        name: r'loadCompletedTasksProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$loadCompletedTasksHash,
        dependencies: LoadCompletedTasksFamily._dependencies,
        allTransitiveDependencies:
            LoadCompletedTasksFamily._allTransitiveDependencies,
        userId: userId,
      );

  LoadCompletedTasksProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
  }) : super.internal();

  final String userId;

  @override
  Override overrideWith(
    Stream<List<Task>> Function(LoadCompletedTasksRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: LoadCompletedTasksProvider._internal(
        (ref) => create(ref as LoadCompletedTasksRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<Task>> createElement() {
    return _LoadCompletedTasksProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LoadCompletedTasksProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin LoadCompletedTasksRef on AutoDisposeStreamProviderRef<List<Task>> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _LoadCompletedTasksProviderElement
    extends AutoDisposeStreamProviderElement<List<Task>>
    with LoadCompletedTasksRef {
  _LoadCompletedTasksProviderElement(super.provider);

  @override
  String get userId => (origin as LoadCompletedTasksProvider).userId;
}

String _$loadIncompletedTasksHash() =>
    r'cbdff373d29681172524a552e4d9ed12edda46b8';

/// See also [loadIncompletedTasks].
@ProviderFor(loadIncompletedTasks)
const loadIncompletedTasksProvider = LoadIncompletedTasksFamily();

/// See also [loadIncompletedTasks].
class LoadIncompletedTasksFamily extends Family<AsyncValue<List<Task>>> {
  /// See also [loadIncompletedTasks].
  const LoadIncompletedTasksFamily();

  /// See also [loadIncompletedTasks].
  LoadIncompletedTasksProvider call(String userId) {
    return LoadIncompletedTasksProvider(userId);
  }

  @override
  LoadIncompletedTasksProvider getProviderOverride(
    covariant LoadIncompletedTasksProvider provider,
  ) {
    return call(provider.userId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'loadIncompletedTasksProvider';
}

/// See also [loadIncompletedTasks].
class LoadIncompletedTasksProvider
    extends AutoDisposeStreamProvider<List<Task>> {
  /// See also [loadIncompletedTasks].
  LoadIncompletedTasksProvider(String userId)
    : this._internal(
        (ref) => loadIncompletedTasks(ref as LoadIncompletedTasksRef, userId),
        from: loadIncompletedTasksProvider,
        name: r'loadIncompletedTasksProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$loadIncompletedTasksHash,
        dependencies: LoadIncompletedTasksFamily._dependencies,
        allTransitiveDependencies:
            LoadIncompletedTasksFamily._allTransitiveDependencies,
        userId: userId,
      );

  LoadIncompletedTasksProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
  }) : super.internal();

  final String userId;

  @override
  Override overrideWith(
    Stream<List<Task>> Function(LoadIncompletedTasksRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: LoadIncompletedTasksProvider._internal(
        (ref) => create(ref as LoadIncompletedTasksRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<Task>> createElement() {
    return _LoadIncompletedTasksProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LoadIncompletedTasksProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin LoadIncompletedTasksRef on AutoDisposeStreamProviderRef<List<Task>> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _LoadIncompletedTasksProviderElement
    extends AutoDisposeStreamProviderElement<List<Task>>
    with LoadIncompletedTasksRef {
  _LoadIncompletedTasksProviderElement(super.provider);

  @override
  String get userId => (origin as LoadIncompletedTasksProvider).userId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
