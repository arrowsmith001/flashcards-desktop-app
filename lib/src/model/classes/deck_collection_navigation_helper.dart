import 'package:flashcard_desktop_app/src/model/entities/deck_collection.dart';

class DeckCollectionNavigationHelper {
  final DeckCollection collection;
  final String currentPath;

  DeckCollectionNavigationHelper(this.collection, this.currentPath) {
    relativePathsFromHere = _getRelativePathsFromPath();
    uniqueSubfolderNames = _getUniqueSubfolderNames(relativePathsFromHere);
    deckIdsHere = _getDeckIdsAtPath();
    allDestinationsUpToAndIncludingHere = _getDestinations();
  }

  late Iterable<String> relativePathsFromHere;
  late Iterable<String> uniqueSubfolderNames;
  late Iterable<String> deckIdsHere;
  late Iterable<String> allDestinationsUpToAndIncludingHere;
  late String lastDestination = allDestinationsUpToAndIncludingHere.last;

  bool get isEmptyHere => deckIdsHere.isEmpty && relativePathsFromHere.isEmpty;

  Iterable<String> _getUniqueSubfolderNames(
          Iterable<String> relativePathsFromHere) =>
      relativePathsFromHere.map((e) => e.split('/').first).toSet().toList();

  Iterable<String> _getRelativePathsFromPath() {
    return collection.paths.where((path) {
      return path != currentPath && path.startsWith(currentPath);
    }).map((fullPath) =>
        fullPath.replaceFirst(currentPath == '' ? '' : '$currentPath/', ''));
  }

  Iterable<String> _getDeckIdsAtPath() {
    return collection.deckIds.where((id) {
      final deckPath = collection.deckIdsToPaths[id];
      return (deckPath == currentPath);
    });
  }

  Iterable<String> _getDestinations() {
    if (currentPath == '') return [''];
    if (!currentPath.contains('/')) return ['', currentPath];

    final allDestinations = <String>[''];
    final lastDestination =
        currentPath.split('/').fold<String>('', (builtUpPath, folderName) {
      if (builtUpPath == '')
        return folderName;
      else
        allDestinations.add(builtUpPath);
      return [builtUpPath, folderName].join('/');
    });
    return allDestinations..add(lastDestination);
  }
}