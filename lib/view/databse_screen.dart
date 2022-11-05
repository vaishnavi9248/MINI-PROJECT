import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:online_voting_system/view/detail_screen.dart';

class DatabaseScreen extends StatefulWidget {
  const DatabaseScreen({Key? key}) : super(key: key);

  @override
  State<DatabaseScreen> createState() => _DatabaseScreenState();
}

class _DatabaseScreenState extends State<DatabaseScreen> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  List<Map<String, dynamic>> list = [];

  Future<void> fetchData() async {
    list = [];
    await db.collection("articles").get().then((event) {
      for (var doc in event.docs) {
        list.add(doc.data());
      }
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(context,
              MaterialPageRoute(builder: (context) => const DetailScreen()));
          fetchData();
        },
      ),
      body: SafeArea(
        child: ListView.separated(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailScreen(
                        title: list[index]["title"],
                      ),
                    ),
                  );
                  fetchData();
                },
                leading: Text("si. ${index + 1}"),
                title: Text(list[index]["title"].toString()),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Divider();
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }
}
