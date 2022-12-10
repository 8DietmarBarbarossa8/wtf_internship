import 'deque.dart';
import 'node.dart';

class DoublyLinkedList<E> implements Deque<E> {
  Node<E>? _headNode, _tailNode;
  int _size = 0;
  final int volume;

  DoublyLinkedList({required this.volume});

  // - вставка в произвольное место по индексу
  void insert(int index, E value) {
    if (index < 0 || index > _size) {
      throw RangeError('Inserting element is out of range!');
    }
    if (_size >= volume) {
      throw Exception('The volume is over!');
    }

    if (index == 0) {
      addFirst(value);
      return;
    } else if (index == _size) {
      addLast(value);
      return;
    }

    final Node<E> newNode = Node(value);
    final Node<E>? iterNode = _goThroughList(index);

    final Node<E>? prevIterNode = iterNode?.previous;
    prevIterNode?.next = newNode;
    newNode.next = iterNode;
    iterNode?.previous = newNode;
    newNode.previous = prevIterNode;

    _size++;
  }

  // - удаления по индексу
  void removeAt(int index) {
    if (_size == 0 || index < 0 || index > _size - 1) {
      throw RangeError('Trying to delete an element in non-existing position');
    }

    Node<E>? bufferNode;
    if (index == 0) {
      bufferNode = _headNode;
      _headNode = bufferNode?.next;
      _headNode?.previous = null;
    } else if (index == size - 1) {
      bufferNode = _tailNode;
      _tailNode = bufferNode?.previous;
      _tailNode?.next = null;
    } else {
      bufferNode = _goThroughList(index);

      final Node<E>? leftNeighbor = bufferNode?.previous;
      final Node<E>? rightNeighbor = bufferNode?.next;
      leftNeighbor?.next = rightNeighbor;
      rightNeighbor?.previous = leftNeighbor;
    }

    _size--;
  }

  void clear() {
    _headNode = null;
    _tailNode = null;
    _size = 0;
  }

  // - получения по индексу
  E? get(int index) {
    if (_size == 0 || index < 0 || index > _size - 1) {
      throw RangeError("There's no element on this position");
    }

    Node node;
    if (index == 0) {
      node = _headNode!;
    } else if (index == _size - 1) {
      node = _tailNode!;
    } else {
      node = _goThroughList(index)!;
    }

    return node.data;
  }

  // - получение размера списка
  int get size => _size;

  // - обновления по индексу
  void update(int index, E value) {
    if (_size == 0 || index < 0 || index > _size - 1) {
      throw RangeError("There's no element on this position");
    }

    Node<E>? newNode = Node(value);
    if (index == 0) {
      final Node<E>? nextNode = _headNode?.next;
      _headNode = newNode;
      _headNode?.next = nextNode;
      nextNode?.previous = _headNode;
    } else if (index == _size - 1) {
      final Node<E>? previousNode = _tailNode?.previous;
      _tailNode = newNode;
      _tailNode?.previous = previousNode;
      previousNode?.next = _tailNode;
    } else {
      final Node<E>? iterNode = _goThroughList(index);
      final Node<E>? leftNode = iterNode?.previous;
      final Node<E>? rightNode = iterNode?.next;
      leftNode?.next = newNode;
      newNode.previous = leftNode;
      rightNode?.previous = newNode;
      newNode.next = rightNode;
    }
  }

  // - преобразования списка в List<E> (`dart:collection`)

  List<E> toList() {
    final List<E> list = [];
    forEach((it) => list.add(it?.data as E));
    return list;
  }

  // Deque interface (realization)

  @override
  void addFirst(E value) {
    if (_size >= volume) {
      throw Exception('The volume is over!');
    }

    final Node<E> newNode = Node(value);
    if (_size == 0) {
      _headNode = newNode;
    } else if (_size == 1) {
      _tailNode = newNode;

      final Node<E>? bufferNode = _headNode;
      _headNode = _tailNode;
      _tailNode = bufferNode;

      _headNode?.next = _tailNode;
      _tailNode?.previous = _headNode;
    } else {
      final Node<E>? bufferNode = _headNode;
      _headNode = newNode;

      _headNode?.next = bufferNode;
      bufferNode?.previous = _headNode;
    }

    _size++;
  }

  @override
  void addLast(E value) {
    if (_size >= volume) {
      throw Exception('The volume is over!');
    }

    final Node<E> newNode = Node(value);
    if (_size == 0) {
      _headNode = newNode;
    } else if (_size == 1) {
      _tailNode = newNode;

      _headNode?.next = _tailNode;
      _tailNode?.previous = _headNode;
    } else {
      final Node<E>? bufferNode = _tailNode;
      _tailNode = newNode;

      _tailNode?.previous = bufferNode;
      bufferNode?.next = _tailNode;
    }

    _size++;
  }

  @override
  E getFirst() {
    final E? value = get(0);
    if (value != null) {
      return value;
    } else {
      throw Exception('No such element!');
    }
  }

  @override
  E getLast() {
    final E? value = get(_size - 1);
    if (value != null) {
      return value;
    } else {
      throw Exception('No such element!');
    }
  }

  @override
  bool offerFirst(E obj) {
    if (_size >= volume) {
      return false;
    } else {
      addFirst(obj);
      return true;
    }
  }

  @override
  bool offerLast(E obj) {
    if (_size >= volume) {
      return false;
    } else {
      addLast(obj);
      return true;
    }
  }

  @override
  E pop() {
    //
    throw UnimplementedError();
  }

  @override
  void push(E obj) => addFirst(obj);

  @override
  E? peekFirst() => _size > 0 ? get(0) : null;

  @override
  E? peekLast() => _size > 0 ? get(_size - 1) : null;

  @override
  E? pollFirst() {
    // TODO: implement pollLast
    throw UnimplementedError();
  }

  @override
  E? pollLast() {
    // TODO: implement pollLast
    throw UnimplementedError();
  }

  @override
  E removeLast() {
    final E? element = get(_size - 1);
    removeAt(_size - 1);
    if (element != null) {
      return element;
    } else {
      throw Exception('The list is empty!');
    }
  }

  @override
  E removeFirst() {
    final E? element = get(0);
    removeAt(0);
    if (element != null) {
      return element;
    } else {
      throw Exception('The list is empty!');
    }
  }

  @override
  bool removeLastOccurrence(Object obj) {
    // TODO: implement removeLastOccurrence
    throw UnimplementedError();
  }

  @override
  bool removeFirstOccurrence(Object obj) {
    // TODO: implement removeFirstOccurrence
    throw UnimplementedError();
  }

  // Other tool methods
  bool get isEmpty => _size == 0;

  bool get isNotEmpty => !isEmpty;

  void forEach(Function(Node<E>? it) action, [bool reverse = false]) {
    Node<E>? iterNode = !reverse ? _headNode : _tailNode;

    if (iterNode == null) return;

    if (!reverse) {
      while (iterNode?.next != null) {
        action(iterNode);
        iterNode = iterNode?.next;
      }
    } else {
      while (iterNode?.previous != null) {
        action(iterNode);
        iterNode = iterNode?.previous;
      }
    }

    action(iterNode);
  }

  Node<E>? _goThroughList(int index) {
    Node<E>? iterNode;
    if (index <= _size / 2) {
      iterNode = _headNode?.next;
      for (int i = 1; i < index; i++) {
        iterNode = iterNode?.next;
      }
    } else {
      iterNode = _tailNode;
      for (int i = _size - 1; i > index; i--) {
        iterNode = iterNode?.previous;
      }
    }
    return iterNode;
  }
}
