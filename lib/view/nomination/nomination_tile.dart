import 'package:flutter/material.dart';

class NominationTile extends StatelessWidget {
  const NominationTile({
    Key? key,
    required this.id,
    required this.candidateName,
    required this.course,
    this.onAccept,
    this.onReject,
    this.status = "",
    this.hideButton = false,
  }) : super(key: key);

  final String candidateName, course, id, status;
  final bool hideButton;
  final void Function()? onAccept, onReject;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          const SizedBox(width: 8.0),
          Expanded(flex: 1, child: Text(id)),
          const SizedBox(width: 8.0),
          const VerticalDivider(
            width: 1,
            color: Colors.grey,
            indent: 1,
          ),
          const SizedBox(width: 8.0),
          Expanded(flex: 5, child: Text(candidateName)),
          const SizedBox(width: 8.0),
          const VerticalDivider(
            width: 1,
            color: Colors.grey,
            indent: 1,
          ),
          const SizedBox(width: 8.0),
          Expanded(flex: 3, child: Text(course)),
          const SizedBox(width: 8.0),
          const VerticalDivider(
            width: 1,
            color: Colors.grey,
            indent: 1,
          ),
          const SizedBox(width: 8.0),
          Expanded(
            flex: 2,
            child: hideButton
                ? const SizedBox()
                : Wrap(
                    alignment: WrapAlignment.spaceEvenly,
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: [
                      ElevatedButton(
                        onPressed: status != "ACCEPTED" ? onAccept : null,
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
                        onPressed: status != "REJECTED" ? onReject : null,
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
          const SizedBox(width: 8.0),
        ],
      ),
    );
  }
}
