import 'package:flutter/material.dart';

class CourseTile extends StatelessWidget {
  const CourseTile({
    Key? key,
    required this.no,
    required this.course,
    this.onDelete,
  }) : super(key: key);

  final String no, course;
  final Function? onDelete;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          const SizedBox(width: 8.0),
          SizedBox(
            width: 32.0,
            child: Text(
              no,
              textAlign: onDelete != null ? TextAlign.start : TextAlign.center,
            ),
          ),
          const SizedBox(width: 8.0),
          const VerticalDivider(
            width: 1,
            color: Colors.grey,
            indent: 1,
          ),
          const SizedBox(width: 8.0),
          Expanded(flex: 5, child: Text(course)),
          const SizedBox(width: 8.0),
          SizedBox(
            width: 100.0,
            child: onDelete != null
                ? ElevatedButton(
                    onPressed: () => onDelete!(),
                    child: const Text("Delete"),
                  )
                : null,
          ),
          const SizedBox(width: 8.0),
        ],
      ),
    );
  }
}
