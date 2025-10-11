// ignore_for_file: deprecated_member_use

import 'package:aeronavigatsiya/data/entity/topic_model.dart';
import 'package:aeronavigatsiya/presentation/teachers/bloc/create_topic/bloc/createtopic_bloc.dart'; // Adjust path if needed
import 'package:aeronavigatsiya/presentation/teachers/bloc/create_topic/bloc/createtopic_event.dart'; // Adjust
import 'package:aeronavigatsiya/presentation/teachers/bloc/create_topic/bloc/createtopic_state.dart'; // Adjust
import 'package:aeronavigatsiya/presentation/teachers/bloc/document_picker/bloc/document_picker_bloc.dart';
import 'package:aeronavigatsiya/presentation/teachers/bloc/document_picker/bloc/document_picker_event.dart';
import 'package:aeronavigatsiya/presentation/teachers/bloc/document_picker/bloc/document_picker_state.dart';
import 'package:aeronavigatsiya/presentation/teachers/bloc/image_picker/bloc/image_picker_bloc.dart';
import 'package:aeronavigatsiya/presentation/teachers/bloc/image_picker/bloc/image_picker_event.dart';
import 'package:aeronavigatsiya/presentation/teachers/bloc/image_picker/bloc/image_picker_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateTopicPage extends StatelessWidget {
  final String chapterId;

  const CreateTopicPage({super.key, required this.chapterId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CreateTopicBloc>(create: (_) => CreateTopicBloc()),
        BlocProvider<ImagePickerBloc>(create: (_) => ImagePickerBloc()),
        BlocProvider<DocumentPickerBloc>(create: (_) => DocumentPickerBloc()),
      ],
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade100, Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
            child: MultiBlocListener(
              listeners: [
                BlocListener<CreateTopicBloc, CreateTopicState>(
                  listener: (context, state) {
                    if (state is CreateSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text(
                            'Mavzu muvaffaqiyatli yaratildi ✅',
                          ),
                          backgroundColor: Colors.green.shade600,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                      Navigator.pop(context);
                    } else if (state is CreateFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                          backgroundColor: Colors.red.shade600,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          duration: const Duration(seconds: 3),
                        ),
                      );
                    }
                  },
                ),
                BlocListener<ImagePickerBloc, ImagePickerState>(
                  listener: (context, state) {
                    if (state is ImageFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                          backgroundColor: Colors.red.shade600,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          duration: const Duration(seconds: 3),
                        ),
                      );
                    }
                  },
                ),
                BlocListener<DocumentPickerBloc, DocumentPickerState>(
                  listener: (context, state) {
                    if (state is DocumentFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                          backgroundColor: Colors.red.shade600,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          duration: const Duration(seconds: 3),
                        ),
                      );
                    }
                  },
                ),
              ],
              child: BlocBuilder<ImagePickerBloc, ImagePickerState>(
                builder: (context, imageState) {
                  return BlocBuilder<DocumentPickerBloc, DocumentPickerState>(
                    builder: (context, docState) {
                      return BlocBuilder<CreateTopicBloc, CreateTopicState>(
                        builder: (context, createState) {
                          final createBloc = context.read<CreateTopicBloc>();
                          return CustomScrollView(
                            slivers: [
                              SliverAppBar(
                                expandedHeight: 140,
                                flexibleSpace: FlexibleSpaceBar(
                                  title: const Text(
                                    "Yangi Mavzu Qo‘shish",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                      fontSize: 20,
                                    ),
                                  ),
                                  background: Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.blue.shade300,
                                          Colors.blue.shade500,
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                    ),
                                  ),
                                ),
                                pinned: true,
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                              ),
                              SliverToBoxAdapter(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Title Input
                                      _buildTitleInput(createBloc, context),
                                      const SizedBox(height: 16),

                                      // Image Picker
                                      _buildImagePicker(context, imageState),
                                      const SizedBox(height: 16),

                                      // Display Selected Image
                                      _buildSelectedImage(imageState),
                                      const SizedBox(height: 16),

                                      // Document Picker
                                      _buildDocumentPicker(context, docState),
                                      const SizedBox(height: 16),

                                      // Display Selected Document
                                      _buildSelectedDocument(docState),
                                      const SizedBox(height: 24),

                                      // Create Button
                                      _buildCreateButton(
                                        context,
                                        createState,
                                        imageState,
                                        docState,
                                        chapterId,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitleInput(CreateTopicBloc bloc, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: bloc.titleController,
        decoration: InputDecoration(
          labelText: "Mavzu Nomi",
          labelStyle: const TextStyle(color: Colors.blueGrey),
          filled: true,
          fillColor: Colors.transparent,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          prefixIcon: const Icon(Icons.title, color: Colors.blue),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
        style: const TextStyle(fontSize: 16, color: Colors.black87),
      ),
    );
  }

  Widget _buildImagePicker(BuildContext context, ImagePickerState imageState) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ElevatedButton.icon(
        onPressed: imageState is ImagePicking
            ? null
            : () => context.read<ImagePickerBloc>().add(PickImage()),
        icon: const Icon(Icons.image, size: 20, color: Colors.white),
        label: Text(
          imageState is ImagePicking
              ? "Rasm yuklanmoqda..."
              : "Preview Rasmini Tanlash",
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue.shade500,
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
      ),
    );
  }

  Widget _buildSelectedImage(ImagePickerState imageState) {
    String? imageUrl;
    if (imageState is ImageLoaded) {
      imageUrl = imageState.imageUrl;
    }
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            Image.network(
              imageUrl ?? "",
              width: double.infinity,
              height: 180,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 180,
                color: Colors.grey.shade200,
                child: const Center(
                  child: Icon(Icons.broken_image, size: 50, color: Colors.grey),
                ),
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDocumentPicker(
    BuildContext context,
    DocumentPickerState docState,
  ) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ElevatedButton.icon(
        onPressed: docState is DocumentPicking
            ? null
            : () => context.read<DocumentPickerBloc>().add(PickDocument()),
        icon: const Icon(Icons.file_upload, size: 20, color: Colors.white),
        label: Text(
          docState is DocumentPicking
              ? "Hujjat yuklanmoqda..."
              : "Hujjat Tanlash (PDF, DOC, DOCX)",
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue.shade500,
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
      ),
    );
  }

  Widget _buildSelectedDocument(DocumentPickerState docState) {
    if (docState is DocumentLoaded) {
      return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: const Row(
          children: [
            Icon(Icons.description, color: Colors.blue, size: 24),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                'Hujjat tanlandi va HTML’ga aylantirildi',
                style: TextStyle(fontSize: 16, color: Colors.black87),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Icon(Icons.check_circle, color: Colors.green, size: 24),
          ],
        ),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildCreateButton(
    BuildContext context,
    CreateTopicState createState,
    ImagePickerState imageState,
    DocumentPickerState docState,
    String chapterId,
  ) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ElevatedButton.icon(
        onPressed: createState is CreateSubmitting
            ? null
            : () {
                final createBloc = context.read<CreateTopicBloc>();
                if (createBloc.titleController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Mavzu nomi kiritilmagan!'),
                      backgroundColor: Colors.red.shade600,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                  return;
                }

                if (imageState is! ImageLoaded || docState is! DocumentLoaded) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text(
                        'Rasm yoki hujjat tanlanmagan yoki HTML’ga aylantirilmagan!',
                      ),
                      backgroundColor: Colors.red.shade600,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                  return;
                }

                final topic = TopicModel(
                  id: '',
                  title: createBloc.titleController.text.trim(),
                  imageUrl: (imageState).imageUrl,
                  content: (docState).htmlContent, // HTML content from document
                  documentUrl: (docState).documentUrl,
                  createdAt: DateTime.now(),
                );

                createBloc.add(CreateTopic(chapterId: chapterId, topic: topic));
              },
        icon: const Icon(Icons.upload, size: 20, color: Colors.white),
        label: createState is CreateSubmitting
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : const Text(
                "Mavzu Yaratish",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green.shade500,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
      ),
    );
  }
}
