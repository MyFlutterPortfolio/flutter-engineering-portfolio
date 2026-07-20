import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:untitled5/core/responsive/responsive_layout.dart';
import 'package:untitled5/core/utils/safe_url_launcher.dart';
import 'package:untitled5/features/alerts/presentation/providers/alerts_provider.dart';
import 'package:untitled5/l10n/generated/app_localizations.dart';

class AlertEventsScreen extends ConsumerWidget {
  const AlertEventsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventsAsync = ref.watch(alertEventsProvider);
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.alertEventsTitle)),
      body: eventsAsync.when(
        data: (events) {
          if (events.isEmpty) {
            return Center(child: Text(l10n.alertEventsEmpty));
          }

          return ResponsivePageFrame(
            child: RefreshIndicator(
              onRefresh: () => ref.refresh(alertEventsProvider.future),
              child: ListView.separated(
                padding: context.responsivePagePadding(top: 16),
                itemCount: events.length,
                separatorBuilder: (context, index) => const Divider(height: 32),
                itemBuilder: (context, index) {
                  final event = events[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.blue.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              event.eventType,
                              style: const TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Text(
                            DateFormat('MMM dd, HH:mm').format(event.createdAt),
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        event.message,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      if (event.triggerPrice != null) ...[
                        const SizedBox(height: 8),
                        Text(
                          l10n.alertEventsTriggeredAt(
                            event.triggerPrice?.toStringAsFixed(2) ?? '--',
                            event.targetPrice?.toStringAsFixed(2) ?? '--',
                          ),
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(fontWeight: FontWeight.w500),
                        ),
                      ],
                      if (event.store != null) ...[
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            const Icon(
                              Icons.store,
                              size: 16,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              event.store!,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            const Spacer(),
                            if (event.storeLink != null)
                              TextButton.icon(
                                onPressed: () => _launchURL(event.storeLink!),
                                icon: const Icon(Icons.open_in_new, size: 16),
                                label: Text(l10n.alertEventsViewDeal),
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: const Size(0, 0),
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                              ),
                          ],
                        ),
                      ],
                    ],
                  );
                },
              ),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) =>
            Center(child: Text(l10n.alertEventsError('$err'))),
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    await launchExternalWebUrl(url);
  }
}
