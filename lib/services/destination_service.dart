import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_app/models/destination_model.dart';
import 'package:logger/logger.dart';

class DestinationService {
  var logger = Logger();
  CollectionReference _destinationRef =
      FirebaseFirestore.instance.collection('destinations');

  Future<List<DestinationModel>> fetchDestinations() async {
    try {
      QuerySnapshot snapshot = await _destinationRef.get();
      List<DestinationModel> destinations = snapshot.docs.map((e) {
        return DestinationModel.fromJson(
            e.id, e.data() as Map<String, dynamic>);
      }).toList();
      return destinations;
    } catch (e) {
      throw e;
    }
  }
}
