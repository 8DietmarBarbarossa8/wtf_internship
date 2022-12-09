/*
- Реализовать двусвязный список на Dart 
самостоятельно (использование встроенных компонентов 
`dart:collection` не допускается). В списке должны 
присутствовать следующие функции:
- вставка в произвольное место по индексу
- удаления по индексу
- получения по индексу
- получение размера списка
- обновления по индексу
- преобразования списка в List<E> (`dart:collection`)
    
Для элементов списка нужно использовать дженерики 
`<T>`, а не конкретный тип.

# Дополнительно
- Реализовать интерфейс Deque для разработанного списка.
*/

main() {
  DoublyLinkedList doublyLinkedList = DoublyLinkedList();

  doublyLinkedList.addLast(3.14);
  doublyLinkedList.addLast('😲');
  doublyLinkedList.addFirst('Herrington');
  doublyLinkedList.addFirst('Billy');
  doublyLinkedList.addLast(25);
  doublyLinkedList.addLast(true);
  doublyLinkedList.addLast('Van Darkholme');
  doublyLinkedList.insert(5, Object());
  doublyLinkedList.removeAt(0);
  doublyLinkedList.removeAt(0);
  doublyLinkedList.removeAt(doublyLinkedList.size - 1);
  doublyLinkedList.removeAt(2);

  doublyLinkedList.forEach((it) => print(it));
}

class Node<T> {
  final T _data;

  Node(this._data);

  Node<T>? previous, next;

  @override
  String toString() => '$_data';
}

class DoublyLinkedList<T> {
  Node<T>? _headNode, _tailNode;
  int _size = 0;

  void insert(int index, T value) {
    if (index < 0 || index > _size) {
      throw RangeError('Inserting element is out of range!');
    }

    if (index == 0) {
      addFirst(value);
      return;
    } else if (index == _size) {
      addLast(value);
      return;
    }

    final Node<T> newNode = Node(value);
    Node<T>? iterNode = _goThroughList(index);

    Node<T>? prevIterNode = iterNode?.previous;
    prevIterNode?.next = newNode;
    newNode.next = iterNode;
    iterNode?.previous = newNode;
    newNode.previous = prevIterNode;

    _size++;
  }

  void addFirst(T value) {
    final Node<T> newNode = Node(value);
    if (_size == 0) {
      _headNode = newNode;
    } else if (_size == 1) {
      _tailNode = newNode;

      Node<T>? bufferNode = _headNode;
      _headNode = _tailNode;
      _tailNode = bufferNode;

      _headNode?.next = _tailNode;
      _tailNode?.previous = _headNode;
    } else {
      Node<T>? bufferNode = _headNode;
      _headNode = newNode;

      _headNode?.next = bufferNode;
      bufferNode?.previous = _headNode;
    }

    _size++;
  }

  void addLast(T value) {
    final Node<T> newNode = Node(value);
    if (_size == 0) {
      _headNode = newNode;
    } else if (_size == 1) {
      _tailNode = newNode;

      _headNode?.next = _tailNode;
      _tailNode?.previous = _headNode;
    } else {
      Node<T>? bufferNode = _tailNode;
      _tailNode = newNode;

      _tailNode?.previous = bufferNode;
      bufferNode?.next = _tailNode;
    }

    _size++;
  }

  void removeAt(int index) {
    if (_size == 0 || index < 0 || index > _size - 1) {
      throw RangeError('Trying to delete an element in non-existing position');
    }

    Node<T>? bufferNode;
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

      Node<T>? leftNeighbor = bufferNode?.previous;
      Node<T>? rightNeighbor = bufferNode?.next;
      leftNeighbor?.next = rightNeighbor;
      rightNeighbor?.previous = leftNeighbor;
    }

    _size--;
  }

  Node<T>? _goThroughList(int index) {
    Node<T>? iterNode;
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

  Node get(int index) {
    if (_size == 0 || index < 0 || index > _size - 1) {
      throw RangeError("There's no element on this position");
    }

    if (index == 0) {
      return _headNode!;
    } else if (index == _size - 1) {
      return _tailNode!;
    } else {
      return _goThroughList(index)!;
    }
  }

  int get size => _size;

  void update(int index, T value) {
    if (_size == 0 || index < 0 || index > _size - 1) {
      throw RangeError("There's no element on this position");
    }

    Node<T>? iterNode;
    if (index == 0) {
      // TODO
    } else if (index == _size - 1) {
    } else {
      iterNode = _goThroughList(index);
    }
  }

  void forEach(Function(Node? it) action, [bool reverse = false]) {
    Node? iterNode = !reverse ? _headNode : _tailNode;

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

  bool get isEmpty => _size == 0;

  bool get isNotEmpty => !isEmpty;

  void clear() {
    _headNode = null;
    _tailNode = null;
    _size = 0;
  }
}

// extension funciton (convert my list to List<E>)

// Deque interface