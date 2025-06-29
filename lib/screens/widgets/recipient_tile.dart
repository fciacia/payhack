import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../app_colors.dart';

class RecipientTile extends StatelessWidget {
  final String avatarUrl;
  final String name;
  final String username;
  final VoidCallback? onTap;

  const RecipientTile({
    super.key,
    required this.avatarUrl,
    required this.name,
    required this.username,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.lace,
      borderRadius: BorderRadius.circular(20),
      elevation: 4,
      shadowColor: AppColors.sapphire.withAlpha((0.08 * 255).round()),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
          child: Row(
            children: [
              Hero(
                tag: 'recipient-avatar-$username',
                child: CircleAvatar(
                  radius: 28,
                  backgroundImage: NetworkImage(avatarUrl),
                  backgroundColor: AppColors.petal,
                  child: avatarUrl.isEmpty
                      ? const FaIcon(
                          FontAwesomeIcons.user,
                          color: AppColors.sapphire,
                        )
                      : null,
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 2),
                  Text(
                    username,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: AppColors.sapphire),
                  ),
                ],
              ),
              const Spacer(),
              const FaIcon(
                FontAwesomeIcons.chevronRight,
                size: 18,
                color: AppColors.lavender,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
