import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'movies_controller.dart';

class MoviesPage extends GetView<MoviesController> {
  const MoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MoviesPage'),
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => Visibility(
            visible: !controller.loading,
            replacement: Container(
              alignment: Alignment.center,
              width: Get.width,
              height: Get.height,
              child: const CircularProgressIndicator(),
            ),
            child: Visibility(
              visible: controller.hasError,
              replacement: _MoviesContent(),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(controller.error),
                    TextButton(
                      onPressed: () => controller.findMovies(),
                      child: const Text('Tentar novamente'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MoviesContent extends GetView<MoviesController> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Container(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Obx(
              () => Text('Films Total: ${controller.totalPages}'),
            ),
          ),
          const SizedBox(height: 20),
          Obx(
            () => Wrap(
              spacing: 10,
              alignment: WrapAlignment.center,
              children: [
                ...controller.movies.map(
                  (films) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 150,
                            child: Image.network(
                              'https://image.tmdb.org/t/p/w500/${films.posterImageUrl}',
                              fit: BoxFit.contain,
                            ),
                          ),
                          Container(
                            constraints: const BoxConstraints(maxWidth: 150),
                            child: Text(
                              films.title,
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ),
                          Container(
                            constraints: const BoxConstraints(maxWidth: 150),
                            child: Text(
                              films.overview,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
