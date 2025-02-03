import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_app/models/destination_model.dart';

class NewDestinationService {
  CollectionReference _newDestinationRef =
      FirebaseFirestore.instance.collection('new_destinations');

  Future<List<DestinationModel>> fetchNewDestinations() async {
    try {
      QuerySnapshot snapshot = await _newDestinationRef.get();
      List<DestinationModel> newDestinations = snapshot.docs.map((e) {
        return DestinationModel.fromJson(
            e.id, e.data() as Map<String, dynamic>);
      }).toList();
      return newDestinations;
    } catch (e) {
      throw e;
    }
  }
}
