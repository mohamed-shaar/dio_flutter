import 'package:dio_trial/api/client.dart';
import 'package:dio_trial/models/post.dart';
import 'package:dio_trial/screens/SinglePostPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => RestClient.create(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(title: 'Dio - Retrofit Trial'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ListView _buildPosts(BuildContext context, List<Post> posts) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 4,
            child: ListTile(
              title: Text(
                posts[index].title,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(posts[index].body),
              onTap: () => _navigateToPost(context, posts[index].id),
            ),
          ),
        );
      },
    );
  }

  void _navigateToPost(BuildContext context, int id) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => SinglePostPage(postId: id,))
    );
  }

  FutureBuilder _buildBody(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<RestClient>(context).getPosts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Text(
              snapshot.error.toString(),
              textAlign: TextAlign.center,
              textScaleFactor: 1.3,
            );
          }
          final List<Post> posts = snapshot.data;
          return _buildPosts(context, posts);
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          child: _buildBody(context),
        ),
      ),
    );
  }

}
