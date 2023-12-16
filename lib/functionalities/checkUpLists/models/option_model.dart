class Option {
  final String id;

  final String title;

  final Map<String, dynamic> options;

  Option({
    required this.id,
    required this.title,
    required this.options,
  });

  @override
  String toString() {
    return 'Option(id: $id, title:$title, options: $options)';
  }
}
