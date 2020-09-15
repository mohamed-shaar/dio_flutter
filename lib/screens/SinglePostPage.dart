import 'package:dio_trial/api/client.dart';
import 'package:dio_trial/models/post.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SinglePostPage extends StatelessWidget {
  final int postId;

  SinglePostPage({this.postId});

  Padding _buildPost(Post post) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Text(
            post.title,
            style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(post.body),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dio Post'),
      ),
      body: FutureBuilder(
        future: Provider.of<RestClient>(context).getPostWithID(postId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final Post post = snapshot.data;
            print('Single post ' + post.toString());
            return _buildPost(post);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
