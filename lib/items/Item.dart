import 'package:meta/meta.dart';

class Item {
  Item({
    @required this.title,
    @required this.subtitle,
  });

  final String title;
  final String subtitle;
}

final List<Item> items = <Item>[
  Item(
    title: 'Апартаменты №1',
    subtitle: 'Все Материалы предназначены исключительно для личного некоммерческого использования в рамках технических возможностей, предоставляемых Сервисом. Любое копирование, воспроизведение, переработка, распространение, доведение до всеобщего сведения либо иное использование Материалов или Базы данных вне рамок возможностей, предоставляемых Сервисом, а также любое их использование в коммерческих целях запрещается.',
  ),
  Item(
    title: 'Апартаменты №2',
    subtitle: 'Все Материалы предназначены исключительно для личного некоммерческого использования в рамках технических возможностей, предоставляемых Сервисом. Любое копирование, воспроизведение, переработка, распространение, доведение до всеобщего сведения либо иное использование Материалов или Базы данных вне рамок возможностей, предоставляемых Сервисом, а также любое их использование в коммерческих целях запрещается.',
  ),
  Item(
    title: 'Апартаменты №3',
    subtitle: 'Все Материалы предназначены исключительно для личного некоммерческого использования в рамках технических возможностей, предоставляемых Сервисом. Любое копирование, воспроизведение, переработка, распространение, доведение до всеобщего сведения либо иное использование Материалов или Базы данных вне рамок возможностей, предоставляемых Сервисом, а также любое их использование в коммерческих целях запрещается.',
  ),
];