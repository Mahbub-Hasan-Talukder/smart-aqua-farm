import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rxdart/subjects.dart';

import '../../../../core/base/cubit/base_cubit.dart';
import '../../../../core/extensions/app_extension.dart';
import '../../../../core/widgets/alerts.dart';
import '../../domain/entity/edit_profile_req.dart';
import '../../domain/entity/fetch_profile_entity.dart';
import '../bloc/cubits/edit_profile/edit_profile_cubit.dart';
import '../../../../core/di/di.dart';
import '../../../../core/navigation/routes.dart';
import '../../../../core/widgets/app_bar.dart';
import '../../../../core/services/auth_service/auth_service.dart';
import '../bloc/cubits/fetch_profile/fetch_profile_cubit.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _fetchProfileCubit = getIt<FetchProfileCubit>();
  final _editProfileCubit = getIt<EditProfileCubit>();
  final _baseCubit = getIt<BaseCubit>();

  final _themeState = BehaviorSubject<String>();
  final _localeState = BehaviorSubject<String>();
  final _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchProfileCubit.fetchProfile();
  }

  @override
  void dispose() {
    _fetchProfileCubit.close();
    _editProfileCubit.close();
    _baseCubit.close();
    _themeState.close();
    _localeState.close();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: 'Profile').build(context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocConsumer<FetchProfileCubit, FetchProfileState>(
            bloc: _fetchProfileCubit,
            listener: (context, state) {
              if (state is FetchProfileFailed) {
                AppAlerts.showSnackBar(
                  context: context,
                  message: state.error,
                  isError: true,
                );
              }
            },
            builder: (context, state) {
              if (state is FetchProfileLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is FetchProfileSuccess) {
                return _buildProfile(context, state.fetchProfileEntity);
              }
              return const Center(child: Text('No profile data found.'));
            },
          ),
        ),
      ),
    );
  }

  Widget _buildProfile(BuildContext context, FetchProfileEntity profile) {
    final authClient = getIt<AuthService>().getAuthClient();

    // Initialize streams and controller with profile data
    _themeState.add(profile.theme);
    _localeState.add(profile.locale);
    _nameController.text = profile.name;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildUserInfo(context, profile),
        _buildSettings(context, profile.theme, profile.locale),
        _buildSignOutButton(context, authClient),
      ],
    );
  }

  Widget _buildUserInfo(BuildContext context, FetchProfileEntity profile) {
    return Column(
      children: [
        const SizedBox(height: 16),
        _buildProfileImage(context, profile),
        const SizedBox(height: 16),
        _buildNameWithEditButton(context, profile),
        Text(
          'Email: ${profile.email}',
          style: Theme.of(context).textTheme.textSmMedium.copyWith(
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ),
      ],
    );
  }

  Widget _buildProfileImage(BuildContext context, FetchProfileEntity profile) {
    return Container(
      width: 110,
      height: 110,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary,
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(55),
        child: Image.network(
          profile.profilePicture,
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildNameWithEditButton(
    BuildContext context,
    FetchProfileEntity profile,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(width: 10),
        Text(
          _nameController.text,
          style: Theme.of(context).textTheme.textxlMedium,
          overflow: TextOverflow.ellipsis,
        ),
        IconButton(
          onPressed: () => _showEditNameDialog(context),
          icon: Icon(Icons.edit, color: Theme.of(context).colorScheme.primary),
        ),
      ],
    );
  }

  void _showEditNameDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Edit Name'),
            content: TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                hintText: 'Enter your name',
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  _editProfileCubit.editProfile(
                    EditProfileReq(name: _nameController.text.trim()),
                  );
                  Navigator.pop(context);
                },
                child: const Text('Save'),
              ),
            ],
          ),
    );
  }

  Widget _buildSettings(BuildContext context, String theme, String locale) {
    final colorTheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 24, horizontal: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Settings', style: textTheme.bodyLarge),
            const Divider(height: 32),
            _buildThemeToggle(context, textTheme, colorTheme, theme),
            _buildLanguageSelector(context, textTheme, locale),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeToggle(
    BuildContext context,
    TextTheme textTheme,
    ColorScheme colorTheme,
    String initialTheme,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Dark Mode', style: textTheme.bodyLarge),
        StreamBuilder<String>(
          stream: _themeState,
          initialData: initialTheme,
          builder: (context, snapshot) {
            final isDark = snapshot.data == 'dark';
            return Switch(
              value: isDark,
              onChanged: (value) {
                final newTheme = value ? 'dark' : 'light';
                _themeState.add(newTheme);
                _baseCubit.toggleTheme();
                _editProfileCubit.editProfile(EditProfileReq(theme: newTheme));
              },
              activeColor: colorTheme.primary,
            );
          },
        ),
      ],
    );
  }

  Widget _buildLanguageSelector(
    BuildContext context,
    TextTheme textTheme,
    String initialLocale,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Language', style: textTheme.bodyLarge),
        StreamBuilder<String>(
          stream: _localeState,
          initialData: initialLocale,
          builder: (context, snapshot) {
            final selectedLocale = snapshot.data ?? 'en';
            return Row(
              children: [
                _buildLanguageChip(
                  context: context,
                  label: 'Bangla',
                  value: 'bn',
                  selected: selectedLocale == 'bn',
                  onTap: () => _updateLocale('bn'),
                ),
                const SizedBox(width: 8),
                _buildLanguageChip(
                  context: context,
                  label: 'English',
                  value: 'en',
                  selected: selectedLocale == 'en',
                  onTap: () => _updateLocale('en'),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  void _updateLocale(String locale) {
    _localeState.add(locale);
    _baseCubit.changeLocale(Locale(locale));
    _editProfileCubit.editProfile(EditProfileReq(locale: locale));
  }

  Widget _buildLanguageChip({
    required BuildContext context,
    required String label,
    required String value,
    required bool selected,
    required VoidCallback onTap,
  }) {
    final colorTheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        height: 32,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: selected ? colorTheme.primary : colorTheme.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? colorTheme.primary : colorTheme.outline,
            width: 1.2,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: textTheme.bodyMedium?.copyWith(
            color: selected ? colorTheme.onPrimary : colorTheme.onSurface,
            fontWeight: selected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildSignOutButton(BuildContext context, authClient) {
    return ElevatedButton(
      onPressed: () async {
        await authClient.signOut();
        if (mounted) {
          context.go(MyRoutes.signInRoute);
        }
      },
      child: const Text('Sign Out'),
    );
  }
}
