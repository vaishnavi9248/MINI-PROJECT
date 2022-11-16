import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_voting_system/const/collection_names.dart';
import 'package:online_voting_system/data/model/nomination_model.dart';
import 'package:online_voting_system/services/firebase_service.dart';
import 'package:online_voting_system/utility/snackbar.dart';
import 'package:online_voting_system/widget/common_heading.dart';
import 'package:online_voting_system/widget/common_scaffold.dart';

class VotingScreen extends StatefulWidget {
  const VotingScreen({Key? key}) : super(key: key);

  @override
  State<VotingScreen> createState() => _VotingScreenState();
}

class _VotingScreenState extends State<VotingScreen> {
  final FirebaseService _firebaseService = FirebaseService();

  late String semesterId;
  late String courseId;
  late String studentId;

  String selectedCandidate = "";

  bool loading = false;

  @override
  void initState() {
    semesterId = Get.parameters['semesterId'] ?? "";
    courseId = Get.parameters['courseId'] ?? "";
    studentId = Get.parameters['studentId'] ?? "";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CommonHeading(title: "Voting Station"),
            StreamBuilder(
              stream: _firebaseService.getNominationsDocs(
                semesterId: semesterId,
                courseId: courseId,
              ),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: Text('Something went wrong'));
                }

                if (snapshot.hasData) {
                  List<DocumentSnapshot> data = snapshot.data!.docs;

                  if (data.isEmpty) {
                    return const Center(child: Text("No Candidates"));
                  }

                  if (data.isNotEmpty) {
                    return ListView.builder(
                      itemCount: data.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        NominationModel nominationData =
                            NominationModel.fromJson(
                                data[index].data() as Map<String, dynamic>);

                        return VoteCard(
                          name: nominationData.candidateName,
                          adNo: nominationData.candidateId,
                          isSelected:
                              nominationData.candidateId == selectedCandidate
                                  ? true
                                  : false,
                          onSelect: () {
                            setState(() {
                              selectedCandidate = nominationData.candidateId;
                            });
                          },
                        );
                      },
                    );
                  }
                }

                return const Center(child: Text("Loading"));
              },
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: loading
                  ? null
                  : () {
                      if (selectedCandidate.isNotEmpty &&
                          studentId.isNotEmpty) {
                        markVote();
                      } else {
                        showSnackBar(
                            context: context,
                            text: "Please select your candidate");
                      }
                    },
              child: Text(loading ? "Submitting..." : "Submit"),
            )
          ],
        ),
      ),
    );
  }

  Future<void> markVote() async {
    setState(() {
      loading = true;
    });
    //increment count in nomination table
    await _firebaseService.incrementCount(selectedCandidate);

    //isVoted true in student table
    await _firebaseService.updateDocById(
      collectionName: CollectionName.students,
      id: studentId,
      data: {"isVoted": true},
    );

    Get.offAllNamed("/");

    showSnackBar(context: context, text: "Successfully marked your vote.");

    setState(() {
      loading = false;
    });
  }
}

class VoteCard extends StatelessWidget {
  const VoteCard({
    Key? key,
    required this.name,
    required this.adNo,
    required this.isSelected,
    required this.onSelect,
  }) : super(key: key);

  final String name;
  final String adNo;
  final bool isSelected;
  final Function onSelect;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        width: 300,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Name: $name"),
                  Text("Ad.No: $adNo"),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                onSelect();
              },
              child: Container(
                height: 45,
                width: 70,
                alignment: Alignment.center,
                child: Text(
                  "Vote",
                  style: TextStyle(
                    color: isSelected ? Colors.blue : Colors.black,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
