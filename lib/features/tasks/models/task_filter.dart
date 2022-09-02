enum TaskFilter {
  all('All'),
  todo('Todo'),
  inProgress('In progress'),
  notCompeted('Not completed'),
  completed('Completed');

  final String title;

  const TaskFilter(this.title);
}
