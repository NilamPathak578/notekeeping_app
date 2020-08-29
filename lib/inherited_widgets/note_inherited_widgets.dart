import 'package:flutter/material.dart';

class NoteInheritedWidget extends InheritedWidget {
  final notes = [
    {
      'title': 'shdgfdhgh sdhfgdshfdsgf hfgshd ',
      "text": 'hgfhf sfhsdf hfgshd gsdfgs fsdg dgsdfhs ftew fyuw ad ewqueqwd',
    },
    {
      'title': 'shdgfdhgh sdhfgdshfdsgf hfgshd ',
      "text": 'hgfhf sfhsdf hfgshd gsdfgs fsdg dgsdfhs ftew fyuw ad ewqueqwd',
    },
    {
      'title': 'shdgfdhgh sdhfgdshfdsgf hfgshd ',
      "text": 'hgfhf sfhsdf hfgshd gsdfgs fsdg dgsdfhs ftew fyuw ad ewqueqwd',
    },
  ];

  NoteInheritedWidget(Widget child) : super(child: child);

  static NoteInheritedWidget of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<NoteInheritedWidget>();
  }

  @override
  bool updateShouldNotify(NoteInheritedWidget oldWidget) {
    return oldWidget.notes != notes;
  }
}
