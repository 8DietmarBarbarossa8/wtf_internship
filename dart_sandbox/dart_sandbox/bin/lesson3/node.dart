class Node<T> {
  final T data;
  Node(this.data);

  Node<T>? previous, next;

  @override
  String toString() => '$data';

  @override
  bool operator ==(Object other) {
    return other is Node &&
        other.runtimeType == runtimeType &&
        other.data == data;
  }

  @override
  int get hashCode => data.hashCode;
}
