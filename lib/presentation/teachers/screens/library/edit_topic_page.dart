// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'package:aeronavigatsiya/data/entity/topic_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uuid/uuid.dart';

class EditTopicPage extends StatefulWidget {
  final TopicModel topic;
  final String chapterId;

  const EditTopicPage({
    super.key,
    required this.topic,
    required this.chapterId,
  });

  @override
  State<EditTopicPage> createState() => _EditTopicPageState();
}

class _EditTopicPageState extends State<EditTopicPage> {
  late TextEditingController _titleController;
  String? _newImageUrl;
  String? _newDocumentUrl;
  String? _newFileType;
  bool _isLoadingImage = false;
  bool _isLoadingDocument = false;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.topic.title);
    _newImageUrl = widget.topic.imageUrl;
    _newDocumentUrl = widget.topic.documentUrl;
    _newFileType = widget.topic.fileType;
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _pickNewImage() async {
    setState(() => _isLoadingImage = true);
    try {
      final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (picked != null) {
        final file = File(picked.path);
        final fileName = const Uuid().v4();
        final ref = FirebaseStorage.instance.ref().child(
          'topic_covers/$fileName',
        );
        await ref.putFile(file);
        final url = await ref.getDownloadURL();
        setState(() {
          _newImageUrl = url;
          _isLoadingImage = false;
        });
      } else {
        setState(() => _isLoadingImage = false);
      }
    } catch (e) {
      setState(() => _isLoadingImage = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Rasm yuklashda xatolik: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _pickNewDocument() async {
    setState(() => _isLoadingDocument = true);
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx'],
      );

      if (result == null || result.files.isEmpty) {
        setState(() => _isLoadingDocument = false);
        return;
      }

      final filePath = result.files.single.path!;
      final file = File(filePath);
      final bytes = await file.readAsBytes();

      if (bytes.length > 10 * 1024 * 1024) {
        setState(() => _isLoadingDocument = false);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Hujjat hajmi 10MB dan katta bo\'lmasligi kerak'),
              backgroundColor: Colors.red,
            ),
          );
        }
        return;
      }

      final extension = result.files.single.extension?.toLowerCase() ?? 'pdf';
      final fileName = const Uuid().v4();
      final ref = FirebaseStorage.instance.ref().child(
        'topic_documents/$fileName.$extension',
      );

      await ref.putFile(file);
      final url = await ref.getDownloadURL();

      setState(() {
        _newDocumentUrl = url;
        _newFileType = extension;
        _isLoadingDocument = false;
      });
    } catch (e) {
      setState(() => _isLoadingDocument = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Hujjat yuklashda xatolik: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _submitUpdate() async {
    if (_titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Mavzu nomi kiritilmagan!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      final updatedTopic = widget.topic.copyWith(
        title: _titleController.text.trim(),
        imageUrl: _newImageUrl ?? widget.topic.imageUrl,
        documentUrl: _newDocumentUrl ?? widget.topic.documentUrl,
        fileType: _newFileType ?? widget.topic.fileType,
      );

      // Firebase'ga yangilash (bu qismni bloc'da yoki repository'da bajarish mumkin)
      // Bu yerda faqat misol uchun direct qilyapmiz
      // Aslida UpdateTopicEvent ni ishlatish kerak

      Navigator.pop(context, updatedTopic);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Mavzu muvaffaqiyatli yangilandi ✅'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      setState(() => _isSubmitting = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Xatolik: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade100, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: CustomScrollView(
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
                        colors: [Colors.blue.shade300, Colors.blue.shade500],
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
                      _buildTitleInput(),
                      const SizedBox(height: 16),
                      _buildImagePicker(),
                      const SizedBox(height: 16),
                      _buildSelectedImage(),
                      const SizedBox(height: 16),
                      _buildDocumentPicker(),
                      const SizedBox(height: 16),
                      _buildSelectedDocument(),
                      const SizedBox(height: 24),
                      _buildUpdateButton(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleInput() {
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
        controller: _titleController,
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

  Widget _buildImagePicker() {
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
        onPressed: _isLoadingImage ? null : _pickNewImage,
        icon: const Icon(Icons.image, size: 20, color: Colors.white),
        label: Text(
          _isLoadingImage ? "Rasm yuklanmoqda..." : "Rasmni Yangilash",
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

  Widget _buildSelectedImage() {
    if (_newImageUrl != null && _newImageUrl!.isNotEmpty) {
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
          child: _isLoadingImage
              ? Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    width: double.infinity,
                    height: 180,
                    color: Colors.grey.shade300,
                  ),
                )
              : Image.network(
                  _newImageUrl!,
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 180,
                    color: Colors.grey.shade200,
                    child: const Center(
                      child: Icon(
                        Icons.broken_image,
                        size: 50,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
        ),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildDocumentPicker() {
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
        onPressed: _isLoadingDocument ? null : _pickNewDocument,
        icon: const Icon(Icons.file_upload, size: 20, color: Colors.white),
        label: Text(
          _isLoadingDocument
              ? "Hujjat yuklanmoqda..."
              : "Hujjatni Yangilash (PDF, DOC, DOCX)",
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

  Widget _buildSelectedDocument() {
    if (_newDocumentUrl != null && _newFileType != null) {
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
        child: Row(
          children: [
            Icon(_getFileIcon(_newFileType!), color: Colors.blue, size: 24),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Hujjat tanlandi (${_newFileType!.toUpperCase()})',
                style: const TextStyle(fontSize: 16, color: Colors.black87),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Icon(Icons.check_circle, color: Colors.green, size: 24),
          ],
        ),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildUpdateButton() {
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
        onPressed: _isSubmitting ? null : _submitUpdate,
        icon: const Icon(Icons.save, size: 20, color: Colors.white),
        label: _isSubmitting
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

  IconData _getFileIcon(String fileType) {
    switch (fileType.toLowerCase()) {
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'doc':
      case 'docx':
        return Icons.description;
      default:
        return Icons.insert_drive_file;
    }
  }
}
