
import 'package:dio/dio.dart';
import 'package:dio_trial/models/post.dart';
import 'package:retrofit/retrofit.dart';

part 'client.g.dart';

@RestApi(baseUrl: 'https://jsonplaceholder.typicode.com/')
abstract class RestClient {
  // factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET('/posts')
  Future<List<Post>> getPosts();

  @GET('/posts/{id}')
  Future<Post> getPostWithID(@Path('id') int id);

  static RestClient create(){
    final Dio dio = Dio();
    return _RestClient(dio);
  }
}