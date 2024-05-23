import 'package:blogger/core/theme/app_platte.dart';
import 'package:blogger/features/blog/presentation/widgets/blog_editor.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AddNewBlogPage extends StatefulWidget {
  const AddNewBlogPage({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  @override
  void didUpdateWidget(covariant AddNewBlogPage oldWidget) {
    titleController.dispose();
    contentController.dispose();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add blog'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.done_rounded))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(11.0),
                child: DottedBorder(
                    color: AppPallete.borderColor,
                    dashPattern: const [10, 4],
                    radius: const Radius.circular(10),
                    borderType: BorderType.RRect,
                    strokeCap: StrokeCap.round,
                    child: const SizedBox(
                      height: 100,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.folder_open),
                          SizedBox(
                            height: 15,
                          ),
                          Text("Select your image"),
                        ],
                      ),
                    )),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    'Technology',
                    'Business',
                    'Programming',
                    'Entertainment'
                  ]
                      .map((e) => Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Chip(
                              label: Text(
                                e,
                                style: const TextStyle(fontSize: 10),
                              ),
                              side: const BorderSide(
                                  color: AppPallete.borderColor),
                            ),
                          ))
                      .toList(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              BlogEditor(controller: titleController, hintText: 'Blog title'),
              const SizedBox(
                height: 15,
              ),
              BlogEditor(controller: contentController, hintText: 'Blog title')
            ],
          ),
        ),
      ),
    );
  }
}
