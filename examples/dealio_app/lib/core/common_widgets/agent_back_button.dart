import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:untitled5/core/common_widgets/glass_container.dart';
import 'package:untitled5/core/theme/agent_ui_tokens.dart';
import 'package:untitled5/core/theme/app_colors.dart';

class AgentBackButton extends StatelessWidget {
  final VoidCallback? onTap;

  const AgentBackButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap:
          onTap ??
          () {
            if (Navigator.of(context).canPop()) {
              context.pop();
              return;
            }
            context.go('/home');
          },
      child: GlassContainer(
        width: AgentUiTokens.iconButton(context),
        height: AgentUiTokens.iconButton(context),
        borderRadius: 14,
        padding: EdgeInsets.zero,
        color: AppColors.adaptiveSurfaceColor(
          context,
          darkAlpha: 0.34,
          lightAlpha: 0.72,
        ),
        child: Icon(
          Iconsax.arrow_left_2,
          color: AppColors.onSurface(context),
          size: 18,
        ),
      ),
    );
  }
}
