import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  TextEditingController textEditingController = TextEditingController();

  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> addData(context) async {
    final data = <String, dynamic>{
      "title": textEditingController.text,
    };

    await db.collection("articles").add(data);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(controller: textEditingController),
          ElevatedButton(
            onPressed: () {
              if (textEditingController.text.isNotEmpty) {
                addData(context);
              }
            },
            child: const Text("Submitted"),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    if (widget.title != null) {
      textEditingController.text = widget.title!;
    }

    super.initState();
  }
}
