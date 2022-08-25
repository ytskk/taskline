import 'package:flutter/material.dart';

class TaskListEmpty extends StatelessWidget {
  const TaskListEmpty({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width / 3 * 2,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'You have no tasks yet.',
                textAlign: TextAlign.center,
                style: theme.textTheme.titleLarge!.copyWith(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Text(
                'Tap anywhere to create a new task.',
                textAlign: TextAlign.center,
                style: theme.textTheme.titleLarge!.copyWith(
                  fontSize: 17,
                  color: theme.textTheme.labelLarge!.color!.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
