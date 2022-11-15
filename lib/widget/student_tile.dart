import 'package:flutter/material.dart';

class StudentTile extends StatelessWidget {
  const StudentTile({
    Key? key,
    required this.name,
    required this.email,
    required this.dob,
    this.hideButton = false,
    required this.id,
    this.onDelete,
    this.onView,
    this.onEdit,
  }) : super(key: key);

  final String name, email, dob, id;
  final bool hideButton;
  final void Function()? onDelete, onView, onEdit;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          const SizedBox(width: 8.0),
          Expanded(flex: 3, child: Text(id)),
          const SizedBox(width: 8.0),
          const VerticalDivider(
            width: 1,
            color: Colors.grey,
            indent: 1,
          ),
          const SizedBox(width: 8.0),
          Expanded(flex: 3, child: Text(name)),
          const SizedBox(width: 8.0),
          const VerticalDivider(
            width: 1,
            color: Colors.grey,
            indent: 1,
          ),
          const SizedBox(width: 8.0),
          Expanded(flex: 4, child: Text(email)),
          const SizedBox(width: 8.0),
          const VerticalDivider(
            width: 1,
            color: Colors.grey,
            indent: 1,
          ),
          const SizedBox(width: 8.0),
          Expanded(flex: 2, child: Text(dob)),
          const SizedBox(width: 8.0),
          Expanded(
            flex: 4,
            child: hideButton
                ? const SizedBox()
                : Wrap(
                    alignment: WrapAlignment.spaceEvenly,
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: [
                      // ElevatedButton(
                      //   onPressed: onView,
                      //   style: ButtonStyle(
                      //     fixedSize:
                      //         MaterialStateProperty.all(const Size(80.0, 0.0)),
                      //     backgroundColor: hideButton
                      //         ? MaterialStateColor.resolveWith(
                      //             (states) => Colors.transparent)
                      //         : null,
                      //     elevation:
                      //         hideButton ? MaterialStateProperty.all(0) : null,
                      //   ),
                      //   child: hideButton ? null : const Text("View"),
                      // ),
                      // ElevatedButton(
                      //   onPressed: onEdit,
                      //   style: ButtonStyle(
                      //     fixedSize:
                      //         MaterialStateProperty.all(const Size(80.0, 0.0)),
                      //     backgroundColor: hideButton
                      //         ? MaterialStateColor.resolveWith(
                      //             (states) => Colors.transparent)
                      //         : null,
                      //     elevation:
                      //         hideButton ? MaterialStateProperty.all(0) : null,
                      //   ),
                      //   child: hideButton ? null : const Text("Edit"),
                      // ),
                      ElevatedButton(
                        onPressed: onDelete,
                        style: ButtonStyle(
                          fixedSize:
                              MaterialStateProperty.all(const Size(80.0, 0.0)),
                          backgroundColor: hideButton
                              ? MaterialStateColor.resolveWith(
                                  (states) => Colors.transparent)
                              : null,
                          elevation:
                              hideButton ? MaterialStateProperty.all(0) : null,
                        ),
                        child: hideButton ? null : const Text("Delete"),
                      ),
                    ],
                  ),
          ),
          const SizedBox(width: 8.0),
        ],
      ),
    );
  }
}
