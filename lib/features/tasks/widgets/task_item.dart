import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskline/features/features.dart';
import 'package:taskline/shared/shared.dart';

class TaskItem extends ConsumerStatefulWidget {
  const TaskItem({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;

  @override
  ConsumerState createState() => _TaskItemState();
}

class _TaskItemState extends ConsumerState<TaskItem>
    with SingleTickerProviderStateMixin {
  late final AnimationController _scaleAnimationController;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    log('new item: ${widget.task.name} was created');
    _scaleAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _scaleAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _scaleAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    _scaleAnimationController.forward();
  }

  @override
  void dispose() {
    _scaleAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ScaleTransition(
      key: ValueKey(widget.task.id),
      scale: _scaleAnimation,
      child: RawMaterialButton(
        onPressed: () {
          log(
            'toggling task status ${widget.task.name} from ${widget.task.status.name} to ${TaskStatus.nextStatus(widget.task.status).name}',
            name: 'TaskItem::_TaskItemState::build::onPressed',
          );
          ref.read(taskListProvider.notifier).toggleTaskStatus(widget.task);
          // HapticFeedback.lightImpact();
        },
        onLongPress: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return TaskEdit(task: widget.task);
            },
          );
        },
        padding: EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 0,
        ),
        constraints: BoxConstraints(
          minHeight: 44.0,
          minWidth: 44.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        splashColor: Colors.transparent,
        // fillColor: Colors.blueAccent,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeInOut,
          style: theme.textTheme.bodyLarge!.copyWith(
            decoration: _matchDecorationByStatus(context, widget.task.status),
            color: _matchColorByStatus(context, widget.task.status),
            fontWeight: FontWeight.w500,
          ),
          child: Text(
            widget.task.name,
          ),
        ),
      ),
    );
  }

  Color _matchColorByStatus(BuildContext context, TaskStatus status) {
    switch (status) {
      case TaskStatus.todo:
        return Theme.of(context).colorScheme.onBackground;
      case TaskStatus.inProgress:
        return Theme.of(context).colorScheme.primary;
      case TaskStatus.done:
        return Theme.of(context).colorScheme.tertiary;
    }
  }

  TextDecoration? _matchDecorationByStatus(
    BuildContext context,
    TaskStatus status,
  ) {
    switch (status) {
      case TaskStatus.todo:
        return null;
      case TaskStatus.inProgress:
        return null;
      case TaskStatus.done:
        return TextDecoration.lineThrough;
    }
  }
}
