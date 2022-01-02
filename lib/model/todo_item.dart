enum CompletitionState {
  toBeDone,
  inProgress,
  completed,
}

class TodoItem {
  final int id;

  final String text;

  final CompletitionState state;

  const TodoItem({
    required this.id,
    required this.text,
    required this.state,
  });

  TodoItem copyWith({
    int? id,
    String? text,
    CompletitionState? state,
  }) {
    return TodoItem(
      id: id ?? this.id,
      text: text ?? this.text,
      state: state ?? this.state,
    );
  }

  @override
  String toString() => 'TodoItem(id: $id, text: $text, state: $state)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TodoItem && other.id == id && other.text == text && other.state == state;
  }

  @override
  int get hashCode => id.hashCode ^ text.hashCode ^ state.hashCode;
}
