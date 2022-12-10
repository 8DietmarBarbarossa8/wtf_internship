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

import 'doubly_linked_list.dart';

main() {
  final DoublyLinkedList dLL = DoublyLinkedList(volume: 10);
// 😳😲
  print('---------------');
  print('Size: ${dLL.size}');
  dLL.addLast(300);
  dLL.addLast('\$');
  dLL.addFirst('Herrington');
  dLL.addFirst('Billy');
  print(dLL.toList());
  print('Size: ${dLL.size}');

  print('---------------');
  print("Insert 'Object()' to position 2");
  dLL.insert(2, Object());
  print(dLL.toList());
  print("Insert true to position 4");
  dLL.insert(4, true);
  print(dLL.toList());

  print('---------------');
  dLL.removeAt(2);
  print(dLL.toList());
  dLL.removeFirst();
  dLL.removeLast();
  print(dLL.toList());

  print('---------------');
  dLL.addFirst(25);
  dLL.addFirst(3.14);
  dLL.addFirst('message');
  dLL.addLast(100);
  dLL.addLast(false);
  dLL.addLast(null);
  dLL.addLast('(2+2)');
  print('Money: ${dLL.get(4)}\$');
  print(dLL.toList());

  print('---------------');
  try {
    dLL.push('');
  } catch (e) {
    print(e.toString());
  }

  print('---------------');
  dLL.update(dLL.size - 1, '4');
  dLL.update(3, 'Харитонов');
  print(dLL.toList());

  print('---------------');
  print('First: ${dLL.peekFirst()}');
  print('Last: ${dLL.peekLast()}');

  print('---------------');
  print('---------------');
}
