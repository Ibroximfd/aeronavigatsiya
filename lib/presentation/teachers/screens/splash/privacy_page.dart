import 'package:aeronavigatsiya/presentation/teachers/bloc/privacy/privacy_bloc.dart';
import 'package:aeronavigatsiya/presentation/teachers/bloc/privacy/privacy_event.dart';
import 'package:aeronavigatsiya/presentation/teachers/bloc/privacy/privacy_state.dart';
import 'package:aeronavigatsiya/presentation/teachers/screens/auth/auth_gate.dart';
import 'package:aeronavigatsiya/presentation/teachers/screens/splash/widgets/privacy_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// [PrivacyPage] - Maxfiylik siyosati sahifasini ko'rsatuvchi asosiy widget.
/// Bu sahifa foydalanuvchiga maxfiylik siyosatini turli tillarda ko'rish va
/// qabul qilish imkonini beradi.
class PrivacyPage extends StatelessWidget {
  /// PageView uchun controller.
  final PageController _pageController = PageController();

  /// Sahifadagi tillar ro'yxati.
  static const List<String> _languages = ['UZ', 'RU', 'EN'];

  PrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Tema ma'lumotlarini olish uchun contextdan foydalanamiz.
    final theme = Theme.of(context);

    return BlocConsumer<PrivacyBloc, PrivacyState>(
      listener: (context, state) {
        // Agar kerak bo'lsa, kelajakda listener ichida qo'shimcha logika qo'shilishi mumkin.
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          appBar: _buildAppBar(theme),
          body: SafeArea(
            child: Column(
              children: [
                _buildPageView(),
                _buildAcceptanceSection(context, state, theme),
                _buildContinueButton(context, state, theme),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  /// AppBar-ni yaratish uchun yordamchi metod.
  PreferredSizeWidget _buildAppBar(ThemeData theme) {
    return AppBar(
      backgroundColor: theme.primaryColor,
      elevation: 0,
      title: const Text(
        'Privacy Policy',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
    );
  }

  /// PageView-ni yaratish uchun yordamchi metod.
  Widget _buildPageView() {
    return Expanded(
      child: PageView.builder(
        controller: _pageController,
        itemCount: _languages.length,
        itemBuilder: (context, index) {
          return PrivacyContent(language: _languages[index]);
        },
      ),
    );
  }

  /// Maxfiylik siyosatini qabul qilish uchun checkbox va matn.
  Widget _buildAcceptanceSection(
    BuildContext context,
    PrivacyState state,
    ThemeData theme,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Checkbox(
            value: state.isAccepted,
            activeColor: theme.primaryColor,
            onChanged: (value) {
              context.read<PrivacyBloc>().add(
                TogglePrivacyAccepted(value ?? false),
              );
            },
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              'I accept the Privacy Policy',
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// "Continue" tugmasini yaratish uchun yordamchi metod.
  Widget _buildContinueButton(
    BuildContext context,
    PrivacyState state,
    ThemeData theme,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        height: 56,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: state.isAccepted
              ? () {
                  context.read<PrivacyBloc>().add(SubmitPrivacyPolicy());
                  Navigator.pushAndRemoveUntil(
                    context,
                    CupertinoPageRoute(builder: (context) => const AuthGate()),
                    (_) => false,
                  );
                }
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: state.isAccepted
                ? theme.primaryColor
                : theme.disabledColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
          ),
          child: const Text(
            'Continue',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
