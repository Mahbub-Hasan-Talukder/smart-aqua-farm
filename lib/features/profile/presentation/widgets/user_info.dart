import 'package:flutter/material.dart';

import '../../domain/entity/edit_profile_req.dart';
import '../../domain/entity/fetch_profile_entity.dart';
import '../bloc/cubits/edit_profile/edit_profile_cubit.dart';

// Replace with your actual entity and cubit imports
// import 'package:your_project/entities/fetch_profile_entity.dart';
// import 'package:your_project/cubit/edit_profile_cubit.dart';

class UserInfoWidget extends StatefulWidget {
  final FetchProfileEntity profile;
  final EditProfileCubit editProfileCubit;

  const UserInfoWidget({
    super.key,
    required this.profile,
    required this.editProfileCubit,
  });

  @override
  State<UserInfoWidget> createState() => _UserInfoWidgetState();
}

class _UserInfoWidgetState extends State<UserInfoWidget> {
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.profile.name);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
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
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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
          style: Theme.of(context).textTheme.titleLarge,
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
                  widget.editProfileCubit.editProfile(
                    EditProfileReq(name: _nameController.text.trim()),
                  );
                  setState(() {}); // Update UI after editing
                  Navigator.pop(context);
                },
                child: const Text('Save'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildUserInfo(context, widget.profile);
  }
}
