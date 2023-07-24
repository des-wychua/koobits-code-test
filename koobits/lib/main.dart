import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/post_controller.dart';
import 'model/Post.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: MainApp(),
    );
  }
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final PostController _postController = Get.put(PostController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: _postController.filterPosts,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  labelText: 'Search',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Expanded(
              child: Obx(
                () {
                  if (_postController.isLoading.value) {
                    return const Center(child: Text('hi'));
                  } else if (_postController.filteredPosts.isEmpty) {
                    return const Center(child: Text('No posts available.'));
                  } else {
                    return ListView.separated(
                      itemCount: _postController.filteredPosts.length,
                      itemBuilder: (context, index) {
                        Post post = _postController.filteredPosts[index];
                        return ListTile(
                          title: Text(post.title),
                          subtitle: Text(post.body),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 16),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
