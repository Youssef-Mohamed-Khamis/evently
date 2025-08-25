import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../model/Event.dart';
import '../../../model/User.dart';

class FirestoreManager{
  static CollectionReference<User> getUserCollection(){
    var collection = FirebaseFirestore.instance.collection("User").withConverter(
      fromFirestore: (snapshot, options) {
        var data = snapshot.data();
        return User.fromFirestore(data);
      },
      toFirestore: (user, options) {
        return user.toFirestore();
      },
    );
    return collection;
  }

  static Future<void> createUser(User user){
    var collection = getUserCollection();
    var document = collection.doc(user.id);
    return document.set(user);

  }

  static Future<User?> getUser(String userId)async{
    var collection = getUserCollection();
    var doc = collection.doc(userId);
    var snapshot = await doc.get();
    var user = snapshot.data();
    return user;
  }
  static CollectionReference<Event> getEventCollection(){
    var collection = FirebaseFirestore.instance.collection("Event").withConverter(
        fromFirestore: (snapshot, options) {
          var data = snapshot.data();
          return Event.fromFirestore(data);
        },
        toFirestore: (event, options) {
          return event.toFirestore();
        },
    );
    return collection;
  }

  static Future<void> createNewEvent(Event event)async{
    var collection = getEventCollection();
    var docRefrence = collection.doc();
    event.id = docRefrence.id;
    return docRefrence.set(event);
  }

  static Future<void> updateEvent(Event event) async {
    var collection = getEventCollection();
    return collection.doc(event.id).update(event.toFirestore());
  }

  static Future<void> deleteEvent(String eventId) async {
    var collection = getEventCollection();
    return collection.doc(eventId).delete();
  }



  static Future<List<Event>> getAllEvents()async{
    var collection = getEventCollection();
    var querySnapshot = await collection.get();
    var docs = querySnapshot.docs;
    List<Event> events = docs.map((document) => document.data()).toList();
    return events;
  }
  static Future<List<Event>> getFilteredEvents(String type)async{
    var collection = getEventCollection().where("type",isEqualTo:type );
    var querySnapshot = await collection.get();
    var docs = querySnapshot.docs;
    List<Event> events = docs.map((document) => document.data()).toList();
    return events;
  }
  static Stream<List<Event>> getAllEventsRealTime()async*{
    var collection = getEventCollection();
    var stream =  collection.snapshots();
    var eventsStream = stream.map((querysnapshot) => querysnapshot.docs.map((doc) => doc.data()).toList());
    yield* eventsStream;
  }
  static Stream<List<Event>> getFilteredEventsRealTime(String type)async*{
    var collection = getEventCollection().where("type",isEqualTo:type );
    var stream =  collection.snapshots();
    var eventsStream = stream.map((querysnapshot) => querysnapshot.docs.map((doc) => doc.data()).toList());
    yield* eventsStream;
  }

  static CollectionReference<Event> getWishlistCollection(String userId){
    var userCollection = getUserCollection();
    var userDoc = userCollection.doc(userId);
    var collection = userDoc.collection("wishlist").withConverter(
      fromFirestore: (snapshot, options) {
        var data = snapshot.data();
        return Event.fromFirestore(data);
      },
      toFirestore: (event, options) {
        return event.toFirestore();
      },
    );
    return collection;
  }

  static Future<void> addEventFavorite(String userId,Event event){
    var collection = getWishlistCollection(userId);
    var doc = collection.doc(event.id);
    return doc.set(event);
  }

  static Future<void> removeEventFavorite(String userId,Event event){
    var collection = getWishlistCollection(userId);
    var doc = collection.doc(event.id);
    return doc.delete();
  }

  static Future<void> updateUserFavorites(String userId,List<String> newFavorites){
    var collection = getUserCollection();
    var doc = collection.doc(userId);
    return doc.update({
      "favorites":newFavorites
    });
  }

  static Stream<List<Event>> getMyWishlist(String userId)async*{
    var collection = getWishlistCollection(userId);
    var stream = collection.snapshots();
    var eventsStream = stream.map((querysnapshot) => querysnapshot.docs.map((doc) => doc.data()).toList());
    yield* eventsStream;
  }


}