import 'package:flutter/material.dart';
import 'package:flutter_treeview/flutter_treeview.dart';

class PathedTree<T> extends StatelessWidget {
  PathedTree(this.dataList,
      {super.key, required this.getPath, required this.buildNode});

  final List<T> dataList;
  final String Function(T) getPath;
  final Widget Function(BuildContext context, String path, T? nodeData) buildNode;

  @override
  Widget build(BuildContext context) {
    final controller = TreeViewController(
      children: [buildTree()],
    );
    return TreeView(
        controller: controller,
        nodeBuilder: (context, node) {
          return buildNode.call(context, node.key, node.data as T?);
        });
  }

  Node<T?> buildTree() {
    AddableTreeNode<T> root = AddableTreeNode<T>(key: '', label: '');

    for (T data in dataList) {
      final String path = getPath(data);
      List<String> parts = path.split('/');
      AddableTreeNode<T> currentNode = root;

      String builtUpName = "";

      for (String part in parts) {
        AddableTreeNode<T> nextNode;
        builtUpName = "$builtUpName/$part";

        if (currentNode.children.any((node) => node.key == builtUpName)) {
          nextNode = currentNode.children
              .firstWhere((node) => node.key == builtUpName);
        } else {
          nextNode = AddableTreeNode(key: builtUpName, label: part);
          currentNode.children.add(nextNode);
        }

        currentNode = nextNode;
      }

      currentNode.data = data;
    }

    return convertToImmutableTree<T>(root);
  }

  Node<T> convertToImmutableTree<T>(AddableTreeNode<T> addableNode) {
    T? data = addableNode.data;
    List<Node<T>> children = addableNode.children
        .map((child) => convertToImmutableTree(child))
        .toList();
    return Node(
        children: children,
        data: data,
        key: addableNode.key,
        label: addableNode.label,
        expanded: true);
  }

  final List<String> selectedDirectoryIds = [];
}

class AddableTreeNode<T> {
  final String key;
  final String label;
  T? data;
  final List<AddableTreeNode<T>> children = [];

  AddableTreeNode({required this.key, required this.label, this.data});
}
