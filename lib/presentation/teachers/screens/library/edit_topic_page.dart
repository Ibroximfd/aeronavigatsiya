// ignore_for_file: deprecated_member_use

import 'package:aviatoruz/data/entity/topic_model.dart';
import 'package:aviatoruz/presentation/teachers/bloc/edit_topic/bloc/edittopic_bloc.dart';
import 'package:aviatoruz/presentation/teachers/bloc/edit_topic/bloc/edittopic_event.dart';
import 'package:aviatoruz/presentation/teachers/bloc/edit_topic/bloc/edittopic_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

class EditTopicPage extends StatelessWidget {
  final TopicModel topic;
  final String chapterId;

  const EditTopicPage(
      {super.key, required this.topic, required this.chapterId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EditTopicBloc(topic),
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade100, Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
            child: BlocConsumer<EditTopicBloc, EditTopicState>(
              listener: (context, state) {
                if (state.success) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Mavzu muvaffaqiyatli yangilandi ✅'),
                      backgroundColor: Colors.green.shade600,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                  Navigator.pop(context);
                } else if (state.failureMessage.isNotEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Xatolik: ${state.failureMessage}'),
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
              builder: (context, state) {
                final bloc = context.read<EditTopicBloc>();

                return CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      expandedHeight: 140,
                      flexibleSpace: FlexibleSpaceBar(
                        title: const Text(
                          "Mavzuni Tahrirlash",
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
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildTitleInput(state, bloc),
                            const SizedBox(height: 16),
                            _buildImagePicker(state, bloc),
                            const SizedBox(height: 16),
                            _buildSelectedImage(state),
                            const SizedBox(height: 16),
                            _buildContentEditor(state, bloc),
                            const SizedBox(height: 24),
                            _buildUpdateButton(state, bloc, chapterId),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitleInput(EditTopicState state, EditTopicBloc bloc) {
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
        controller: TextEditingController(text: state.title),
        onChanged: (val) => bloc.add(ChangeTitleEvent(val)),
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
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        style: const TextStyle(fontSize: 16, color: Colors.black87),
      ),
    );
  }

  Widget _buildImagePicker(EditTopicState state, EditTopicBloc bloc) {
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
        onPressed:
            state.isLoadingImage ? null : () => bloc.add(PickNewImageEvent()),
        icon: const Icon(Icons.image, size: 20, color: Colors.white),
        label: Text(
          state.isLoadingImage ? "Rasm yuklanmoqda..." : "Rasmni Yangilash",
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

  Widget _buildSelectedImage(EditTopicState state) {
    if (state.imageUrl.isNotEmpty) {
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
          child: Image.network(
            state.imageUrl,
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
        ),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildContentEditor(EditTopicState state, EditTopicBloc bloc) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Column(
        children: [
          quill.QuillSimpleToolbar(
            controller: quill.QuillController(
              document: state.content,
              selection: const TextSelection.collapsed(offset: 0),
            ),
          ),
          Container(
            height: 300,
            padding: const EdgeInsets.all(8),
            child: quill.QuillEditor.basic(
              controller: quill.QuillController(
                document: state.content,
                selection: const TextSelection.collapsed(offset: 0),
              ),
              config: const quill.QuillEditorConfig(
                placeholder: "Mavzu kontentini kiriting...",
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUpdateButton(
      EditTopicState state, EditTopicBloc bloc, String chapterId) {
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
        onPressed: state.isSubmitting
            ? null
            : () => bloc.add(SubmitUpdateEvent(chapterId: chapterId)),
        icon: const Icon(Icons.save, size: 20, color: Colors.white),
        label: state.isSubmitting
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : const Text(
                "Mavzuni Yangilash",
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
