// ignore_for_file: deprecated_member_use

import 'package:aeronavigatsiya/data/entity/video_model.dart';
import 'package:aeronavigatsiya/presentation/teachers/bloc/videos_bloc/bloc/videos_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VideoCreatePage extends StatefulWidget {
  const VideoCreatePage({super.key});

  @override
  State<VideoCreatePage> createState() => _VideoCreatePageState();
}

class _VideoCreatePageState extends State<VideoCreatePage> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final videoUrlController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    videoUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VideosBloc(),
      child: BlocConsumer<VideosBloc, VideosState>(
        listener: (context, state) {
          if (state is VideosLoading) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Yuklanmoqda...'),
                backgroundColor: Colors.orange,
                behavior: SnackBarBehavior.floating,
              ),
            );
          } else if (state is VideosLoaded) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text("Yangi video muvaffaqiyatli qo‘shildi ✅"),
                backgroundColor: Colors.green.shade600,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            );
          } else if (state is VideosError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Xatolik: ${state.message}"),
                backgroundColor: Colors.red.shade600,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        builder: (context, state) {
          // 🔹 Bloc orqali path olish (masalan, yuklangan video yo‘li)
          String? blocPath;
          if (state is VideosLoaded && state is! VideosError) {
            // agar path blocda bo‘lsa, repository yoki state’dan olingan bo‘lishi mumkin
            // misol uchun: state.currentPath yoki repository.currentPath()
            // quyida placeholder sifatida yozamiz:
            blocPath = "https://example.com/video.mp4"; // misol uchun
          }

          // 🔹 UI
          return Scaffold(
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.red.shade100, Colors.white],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    expandedHeight: 140,
                    pinned: true,
                    backgroundColor: Colors.transparent,
                    flexibleSpace: FlexibleSpaceBar(
                      title: const Text(
                        'Yangi Video Qo‘shish',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          fontSize: 20,
                          shadows: [
                            Shadow(
                              blurRadius: 4,
                              color: Colors.black45,
                              offset: Offset(1, 1),
                            ),
                          ],
                        ),
                      ),
                      background: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.red.shade300, Colors.red.shade500],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: const BorderRadius.vertical(
                            bottom: Radius.circular(24),
                          ),
                        ),
                      ),
                    ),
                    leading: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black87,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),

                  // FORM
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _buildInputField(
                            controller: titleController,
                            label: "Video Nomi",
                            icon: Icons.title,
                          ),
                          const SizedBox(height: 16),
                          _buildInputField(
                            controller: descriptionController,
                            label: "Tavsif",
                            icon: Icons.description,
                            maxLines: 3,
                          ),
                          const SizedBox(height: 16),
                          _buildInputField(
                            controller: videoUrlController
                              ..text = blocPath ?? "",
                            label: "Video URL (Blocdan)",
                            icon: Icons.play_circle_outline,
                          ),
                          const SizedBox(height: 24),

                          // 🔹 CREATE BUTTON
                          ElevatedButton.icon(
                            onPressed: () {
                              final title = titleController.text.trim();
                              final desc = descriptionController.text.trim();
                              final url = videoUrlController.text.trim();

                              if (title.isEmpty ||
                                  desc.isEmpty ||
                                  url.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text(
                                      "Barcha maydonlarni to‘ldiring!",
                                    ),
                                    backgroundColor: Colors.red.shade600,
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                                return;
                              }

                              // Avtomatik ID generatsiya (Firebase uchun temp, Bloc'da almashtiriladi)
                              final autoId =
                                  'video_${DateTime.now().millisecondsSinceEpoch}';

                              final video = VideoModel(
                                id: autoId,
                                title: title,
                                description: desc,
                                videoUrl: url,
                                createdAt: DateTime.now(),
                              );

                              context.read<VideosBloc>().add(AddVideo(video));
                            },
                            icon: const Icon(Icons.upload, color: Colors.white),
                            label: const Text(
                              "Yaratish",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red.shade600,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          const SizedBox(height: 80),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red.shade200, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.red.shade100.withOpacity(0.4),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.red),
          labelText: label,
          labelStyle: TextStyle(color: Colors.red.shade700),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
        ),
      ),
    );
  }
}
