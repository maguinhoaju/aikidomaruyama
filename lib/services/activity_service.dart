import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aikidomaruyama/models/activity_model.dart';

class ActivityService {
  late CollectionReference _activities;

  ActivityService() {
    final firebaseFirestore = FirebaseFirestore.instance;
    _activities = firebaseFirestore.collection('activities');
  }

  Future<String> add(Activity activity) async {
    var docRef = await _activities.add(activity.toMap());
    return docRef.id;
  }

  Future<List<Activity>> getAll() async {
    var snapshot = await _activities.get();
    return snapshot.docs.map((docRef) {
      var docMap = docRef.data() as Map<String, dynamic>;
      return Activity.fromMap(docMap, docRef.id);
    }).toList();
  }

  Future<Activity?> getById(String id) async {
    var docRef = await _activities.doc(id).get();
    if (docRef.exists) {
      var docMap = docRef.data() as Map<String, dynamic>;
      return Activity.fromMap(docMap, docRef.id);
    }
    return null;
  }

  Future<void> update(Activity activity) async {
    await _activities.doc(activity.id).update(activity.toMap());
  }

  Future<void> delete(String id) async {
    await _activities.doc(id).delete();
  }
}
