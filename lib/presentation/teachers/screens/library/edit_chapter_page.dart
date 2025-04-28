// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'package:aviatoruz/data/entity/chapter_model.dart';
import 'package:aviatoruz/presentation/teachers/bloc/library/library_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class EditChapterPage extends StatefulWidget {
  final ChapterModel chapter;

  const EditChapterPage({super.key, required this.chapter});

  @override
  State<EditChapterPage> createState() => _EditChapterPageState();
}

class _EditChapterPageState extends State<EditChapterPage> {
  late TextEditingController _nameController;
  String? _newImageUrl;
  File? pickedImageFile;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.chapter.name);
    _newImageUrl = widget.chapter.imageUrl;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LibraryBloc, LibraryState>(
      listener: (context, state) {
        if (state is LibrarySuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text("Bob muvaffaqiyatli yaratildi ✅"),
              backgroundColor: Colors.green.shade600,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );
          Navigator.pop(context);
        } else if (state is LibraryFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Xatolik: ${state.message}"),
              backgroundColor: Colors.red.shade600,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        final bloc = context.read<LibraryBloc>();

        return Scaffold(
          appBar: AppBar(
            title: const Text('Bobni tahrirlash'),
          ),
          body: BlocListener<LibraryBloc, LibraryState>(
            listener: (context, state) {
              if (state is LibraryImagePicked) {
                setState(() {
                  _newImageUrl = state.imageUrl;
                });
              } else if (state is LibraryFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Name input
                    TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Bob nomi',
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Image Preview
                    ElevatedButton.icon(
                      onPressed: state is LibraryLoading
                          ? null
                          : () => bloc.add(PickChapterImageEvent()),
                      icon: Icon(
                        Icons.image,
                        color: Colors.white,
                        size: 24,
                      ),
                      label: Text(
                        state is LibraryImagePicking
                            ? "Rasm yuklanmoqda..."
                            : "Bob Preview Rasmi",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade600,
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 4,
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Display Selected Image
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.green.shade200,
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.green.shade100.withOpacity(0.4),
                            spreadRadius: 2,
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: state is LibraryImagePicked
                            ? Image.network(
                                state.imageUrl,
                                width: double.infinity,
                                height: 200,
                                fit: BoxFit.cover,
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Shimmer.fromColors(
                                    baseColor: Colors.grey.shade200,
                                    highlightColor: Colors.green.shade100,
                                    period: const Duration(milliseconds: 1200),
                                    child: Container(
                                      width: double.infinity,
                                      height: 200,
                                      color: Colors.grey.shade200,
                                    ),
                                  );
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: double.infinity,
                                    height: 200,
                                    color: Colors.grey.shade200,
                                    child: const Center(
                                      child: Icon(
                                        Icons.broken_image,
                                        color: Colors.grey,
                                        size: 50,
                                      ),
                                    ),
                                  );
                                },
                              )
                            : Container(
                                width: double.infinity,
                                height: 200,
                                color: Colors.grey.shade200,
                                child: const Center(
                                  child: Icon(
                                    Icons.image_outlined,
                                    color: Colors.grey,
                                    size: 50,
                                  ),
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        final updatedChapter = widget.chapter.copyWith(
                          name: _nameController.text.trim(),
                          imageUrl: _newImageUrl ?? widget.chapter.imageUrl,
                        );
                        context
                            .read<LibraryBloc>()
                            .add(UpdateChapterEvent(updatedChapter));
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: Colors.deepPurple,
                      ),
                      child: const Text(
                        'Saqlash',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
