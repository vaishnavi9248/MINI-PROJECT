import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:online_voting_system/const/collection_names.dart';
import 'package:online_voting_system/data/model/nomination_model.dart';
import 'package:online_voting_system/services/firebase_service.dart';
import 'package:online_voting_system/view/nomination/nomination_tile.dart';
import 'package:online_voting_system/widget/common_heading.dart';
import 'package:online_voting_system/widget/common_scaffold.dart';

class NominationList extends StatelessWidget {
  const NominationList({Key? key}) : super(key: key);

  static final FirebaseService _firebaseService = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CommonHeading(title: "Nomination List"),
          const SizedBox(height: 8.0),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                  style: BorderStyle.solid,
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 8.0),
                  const NominationTile(
                    id: "Ad.No",
                    candidateName: "Name",
                    hideButton: true,
                    course: "Course",
                  ),
                  const SizedBox(height: 8.0),
                  const Divider(
                    height: 1,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 8.0),
                  Expanded(
                    child: StreamBuilder(
                      stream: _firebaseService.getCollectionStream(
                        collectionName: CollectionName.nomination,
                        orderBy: "candidateId",
                      ),
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        if (snapshot.hasError) {
                          return const Center(
                              child: Text('Something went wrong'));
                        }

                        if (snapshot.hasData) {
                          List<DocumentSnapshot> data = snapshot.data!.docs;

                          if (data.isEmpty) {
                            return const Center(child: Text("No Nominations"));
                          }

                          if (data.isNotEmpty) {
                            return ListView.separated(
                              itemCount: data.length,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                NominationModel nominationModel =
                                    NominationModel.fromJson(data[index].data()
                                        as Map<String, dynamic>);

                                return NominationTile(
                                  id: nominationModel.candidateId,
                                  candidateName:
                                      "Candidate Name: ${nominationModel.candidateName}\n"
                                      "Primary Proposer: ${nominationModel.proposer1Name}\n"
                                      "Secondary Proposer: ${nominationModel.proposer2Name}\n",
                                  course:
                                      "${nominationModel.candidateCourse}\n${nominationModel.candidateSemester}",
                                  status: nominationModel.status,
                                  onAccept: () {
                                    _firebaseService.updateDocById(
                                        collectionName:
                                            CollectionName.nomination,
                                        id: nominationModel.candidateId,
                                        data: {"status": "ACCEPTED"});
                                  },
                                  onReject: () {
                                    _firebaseService.updateDocById(
                                        collectionName:
                                            CollectionName.nomination,
                                        id: nominationModel.candidateId,
                                        data: {"status": "REJECTED"});
                                  },
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2.0),
                                  child: Divider(),
                                );
                              },
                            );
                          }
                        }

                        return const Center(child: Text("Loading..."));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
