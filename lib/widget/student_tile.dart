import 'package:flutter/material.dart';

class StudentTile extends StatelessWidget {
  const StudentTile({
    Key? key,
    required this.name,
    required this.email,
    required this.dob,
    this.hideButton = false,
    required this.id,
  }) : super(key: key);

  final String name, email, dob, id;
  final bool hideButton;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 2, child: Text(id)),
        const SizedBox(width: 8.0),
        Expanded(flex: 2, child: Text(name)),
        const SizedBox(width: 8.0),
        Expanded(flex: 3, child: Text(email)),
        const SizedBox(width: 8.0),
        Expanded(flex: 1, child: Text(dob)),
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
                    ElevatedButton(
                      onPressed: () {},
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
                      child: hideButton ? null : const Text("View"),
                    ),
                    ElevatedButton(
                      onPressed: () {},
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
                      child: hideButton ? null : const Text("Accept"),
                    ),
                    ElevatedButton(
                      onPressed: () {},
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
                      child: hideButton ? null : const Text("Reject"),
                    ),
                  ],
                ),
        ),
      ],
    );
  }
}
