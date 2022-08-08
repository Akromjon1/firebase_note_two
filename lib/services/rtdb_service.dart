import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_note_two/services/auth_service.dart';

import '../model/post_model.dart';

class RTDBService{
  static final database  = FirebaseDatabase.instance.ref();

  static Future<Stream<DatabaseEvent>> storePost(Post post)async{
    await database.child("post").child(AuthService.auth.currentUser!.uid).push().set(post.toJson());
    return database.onChildAdded;
  }

  static Future<Stream<DatabaseEvent>> deletePost(key)async{
    await database.child("post").child(AuthService.auth.currentUser!.uid).child(key).remove();
    return database.onChildAdded;
  }

  static Future<Stream<DatabaseEvent>> deleteAllPost()async{
    await database.child("post").child(AuthService.auth.currentUser!.uid).remove();
    return database.onChildAdded;
  }

  static Future<Stream<DatabaseEvent>> updatePost(Post post, key)async{
    await database.child("post").child(AuthService.auth.currentUser!.uid).child(key).update(post.toJson());
    return database.onChildAdded;
  }

  static Future<List<Post>>loadPost(String id)async{
    List<Post> items = [];
    Query query = database.child("post").orderByChild("userId").equalTo(id);
    var snapshot = await query.once();
    var result = snapshot.snapshot.children;

    for(DataSnapshot item in result){
      if(item.value != null){
        items.add(Post.fromJson(Map<String, dynamic>.from(item.value as Map)));
      }
    }
    return items;
  }

  static List<Post> parseSnapshot(DatabaseEvent? event){
    List<Post> items = [];
    if(event == null) return items;

    var result = event.snapshot.children;
    for(DataSnapshot item in result){
        if(item.value != null){
          items.add(Post.fromJson(Map<String, dynamic>.from(item.value as Map)));
        }
    }
    return items;
  }
}