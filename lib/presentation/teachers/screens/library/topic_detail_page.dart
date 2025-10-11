import 'package:aeronavigatsiya/data/entity/topic_model.dart';
import 'package:aeronavigatsiya/presentation/teachers/bloc/topic_detail/bloc/topicdetail_bloc.dart';
import 'package:aeronavigatsiya/presentation/teachers/bloc/topic_detail/bloc/topicdetail_event.dart';
import 'package:aeronavigatsiya/presentation/teachers/bloc/topic_detail/bloc/topicdetail_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class TopicDetailPage extends StatelessWidget {
  final TopicModel topic;

  const TopicDetailPage({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TopicDetailBloc()..add(LoadTopicDetail(topic)),
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        body: BlocBuilder<TopicDetailBloc, TopicDetailState>(
          builder: (context, state) {
            return CustomScrollView(
              slivers: [
                _buildAppBar(context),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),
                      child: _buildContent(state),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  /// --- APP BAR ---
  SliverAppBar _buildAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 240,
      pinned: true,
      backgroundColor: Colors.white,
      elevation: 1,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          topic.title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.black87,
            fontSize: 16,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        background: Image.network(
          topic.imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Container(
            color: Colors.grey.shade200,
            child: const Center(
              child: Icon(Icons.broken_image, size: 50, color: Colors.grey),
            ),
          ),
          loadingBuilder: (context, child, progress) {
            if (progress == null) return child;
            return Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(color: Colors.grey.shade300),
            );
          },
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  /// --- MAIN CONTENT ---
  Widget _buildContent(TopicDetailState state) {
    if (state is TopicDetailLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(60),
          child: CircularProgressIndicator(color: Colors.teal),
        ),
      );
    } else if (state is TopicDetailError) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 80),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error_outline, color: Colors.red.shade600, size: 48),
              const SizedBox(height: 12),
              Text(
                state.message,
                style: TextStyle(
                  color: Colors.red.shade600,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    } else if (state is TopicDetailLoadedHtml) {
      final safeHtml = _sanitizeHtml(state.contentHtml);

      return Container(
        margin: const EdgeInsets.symmetric(vertical: 24),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Html(
          data: safeHtml,
          onLinkTap: (url, _, __) {
            if (url == null) return;
            final Uri uri = Uri.parse(url);

            // async ishni Future ichida bajarish
            Future(() async {
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri, mode: LaunchMode.externalApplication);
              } else {
                debugPrint("Cannot open URL: $url");
              }
            });
          },

          style: {
            "body": Style(
              fontSize: FontSize(16),
              color: Colors.black87,
              fontFamily: 'Georgia',
              lineHeight: const LineHeight(1.8),
              textAlign: TextAlign.justify,
              margin: Margins.zero,
              padding: HtmlPaddings.zero,
            ),
            "p": Style(margin: Margins.only(bottom: 14)),
            "a": Style(
              color: Colors.blue.shade700,
              textDecoration: TextDecoration.underline,
            ),
            "h1": Style(
              color: Colors.black,
              fontSize: FontSize(20),
              fontWeight: FontWeight.w700,
              margin: Margins.only(bottom: 8, top: 16),
            ),
            "h2": Style(
              color: Colors.black87,
              fontSize: FontSize(18),
              fontWeight: FontWeight.w600,
              margin: Margins.only(bottom: 6, top: 14),
            ),
            "strong": Style(fontWeight: FontWeight.w700),
            "table": Style(
              border: Border.all(color: Colors.grey.shade300),
              padding: HtmlPaddings.all(4),
            ),
            "img": Style(
              width: Width.auto(),
              height: Height.auto(),
              margin: Margins.symmetric(vertical: 12),
            ),
            "ul": Style(
              padding: HtmlPaddings.only(left: 24),
              margin: Margins.only(bottom: 14),
            ),
            "ol": Style(
              padding: HtmlPaddings.only(left: 24),
              margin: Margins.only(bottom: 14),
            ),
          },
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  /// --- HTML SANITIZER ---
  String _sanitizeHtml(String html) {
    return html
        .replaceAll(RegExp(r'&nbsp;'), ' ')
        .replaceAll(RegExp(r'\s{2,}'), ' ')
        .replaceAll(RegExp(r'\n+'), '\n')
        .replaceAll(RegExp(r'\r+'), '')
        .replaceAll(RegExp(r'\t+'), '')
        .replaceAll(RegExp(r'margin\s*:\s*-[0-9]+px'), '')
        .replaceAll(RegExp(r'width\s*:\s*-[0-9]+px'), '')
        .trim();
  }
}
