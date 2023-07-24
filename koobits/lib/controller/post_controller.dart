import 'package:get/get.dart';
import 'package:koobits/model/Post.dart';
import 'package:koobits/service/post_api.dart';

class PostController extends GetxController {
  final PostApi _postApi = PostApi();
  final RxList<Post> filteredPosts = <Post>[].obs;
  List<Post> allPost = [];
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchPosts();
    super.onInit();
  }

  void fetchPosts() async {
    try {
      allPost = await _postApi.fetchPosts();
      filteredPosts.assignAll(allPost);
    } catch (e) {
      print('Unable to fetch data');
    } finally {
      isLoading.value = false;
    }
  }

  void filterPosts(String query) {
    if (query.isEmpty) {
      filteredPosts.assignAll(allPost);
      return;
    }

    final result = allPost.where((post) =>
        post.title.toLowerCase().contains(query.toLowerCase().trim()));
    // Update the posts list with filtered results
    filteredPosts.assignAll(result);
  }
}
