enum TaskFilter {
  all('All'),
  todo('Todo'),
  inProgress('In progress'),
  completed('Completed');

  final String title;

  const TaskFilter(this.title);
}
