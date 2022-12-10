class Node<T> {
  final T data;

  Node(this.data);

  Node<T>? previous, next;

  @override
  String toString() => '$data';
}