import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled5/core/network/api_client.dart';
import 'package:untitled5/core/network/api_endpoints.dart';
import 'package:untitled5/core/network/failures.dart';

class AIChatReply {
  final String message;
  final String? threadId;
  final List<String> sources;
  final Map<String, dynamic> metadata;

  const AIChatReply({
    required this.message,
    this.threadId,
    this.sources = const <String>[],
    this.metadata = const <String, dynamic>{},
  });
}

class AIChatThread {
  final String id;
  final String title;
  final String? lastMessage;
  final int messageCount;
  final DateTime? updatedAt;
  final DateTime? createdAt;

  const AIChatThread({
    required this.id,
    required this.title,
    this.lastMessage,
    this.messageCount = 0,
    this.updatedAt,
    this.createdAt,
  });

  factory AIChatThread.fromJson(Map<String, dynamic> json) {
    final id = json['id']?.toString().trim() ?? '';
    final title = json['title']?.toString().trim() ?? '';
    final lastMessage = json['lastMessage']?.toString().trim();
    final messageCount = int.tryParse(json['messageCount']?.toString() ?? '');
    final updatedAtRaw = json['updatedAt']?.toString();
    final createdAtRaw = json['createdAt']?.toString();

    return AIChatThread(
      id: id,
      title: title.isEmpty ? 'New chat' : title,
      lastMessage: lastMessage == null || lastMessage.isEmpty
          ? null
          : lastMessage,
      messageCount: messageCount ?? 0,
      updatedAt: updatedAtRaw == null ? null : DateTime.tryParse(updatedAtRaw),
      createdAt: createdAtRaw == null ? null : DateTime.tryParse(createdAtRaw),
    );
  }
}

class AIChatHistoryItem {
  final String id;
  final String? threadId;
  final String text;
  final bool isAi;
  final DateTime? createdAt;
  final List<String> sources;
  final Map<String, dynamic> metadata;

  const AIChatHistoryItem({
    required this.id,
    this.threadId,
    required this.text,
    required this.isAi,
    required this.createdAt,
    this.sources = const <String>[],
    this.metadata = const <String, dynamic>{},
  });
}

class AIChatRepository {
  final ApiClient _apiClient;

  AIChatRepository(this._apiClient);

  Future<AIChatReply> sendMessage({
    required String message,
    String? threadId,
    String? productId,
  }) async {
    try {
      final payload = <String, dynamic>{'message': message.trim()};
      final safeThreadId = threadId?.trim();
      if (safeThreadId != null && safeThreadId.isNotEmpty) {
        payload['threadId'] = safeThreadId;
      }
      if ((productId ?? '').trim().isNotEmpty) {
        payload['productId'] = productId!.trim();
      }

      final response = await _apiClient.dio.post(
        ApiEndpoints.aiChat,
        data: payload,
      );

      final data = response.data;
      if (data is Map) {
        final map = Map<String, dynamic>.from(data);
        final messageText = map['message']?.toString().trim() ?? '';
        if (messageText.isEmpty) {
          throw AppException.unknown('Empty assistant response');
        }

        final metadata = _extractMetadata(map['metadata']);
        final sources = _extractSources(metadata);

        return AIChatReply(
          message: messageText,
          threadId:
              map['threadId']?.toString().trim().isNotEmpty == true
              ? map['threadId'].toString().trim()
              : metadata['threadId']?.toString().trim(),
          sources: sources,
          metadata: metadata,
        );
      }

      throw AppException.unknown('Invalid chat response format');
    } catch (e) {
      throw e is AppException ? e : AppException.unknown(e);
    }
  }

  Future<List<AIChatHistoryItem>> getHistory({
    int limit = 40,
    String? threadId,
  }) async {
    try {
      final safeThreadId = threadId?.trim();
      final response = await _apiClient.dio.get(
        ApiEndpoints.aiChatHistory,
        queryParameters: {
          'limit': limit < 1 ? 1 : (limit > 200 ? 200 : limit),
          if (safeThreadId != null && safeThreadId.isNotEmpty)
            'threadId': safeThreadId,
        },
      );

      final data = response.data;
      if (data is! List) return const <AIChatHistoryItem>[];

      return data
          .whereType<Map>()
          .map((raw) {
            final map = Map<String, dynamic>.from(raw);
            final id = map['id']?.toString() ?? '';
            final role = (map['role']?.toString().toLowerCase() ?? 'assistant');
            final content = map['content']?.toString() ?? '';
            final createdAtRaw = map['createdAt']?.toString();
            final createdAt = createdAtRaw != null
                ? DateTime.tryParse(createdAtRaw)
                : null;
            final metadata = _extractMetadata(map['metadata']);
            final sources = _extractSources(metadata);

            return AIChatHistoryItem(
              id: id,
              threadId: map['threadId']?.toString().trim(),
              text: content,
              isAi: role != 'user',
              createdAt: createdAt,
              sources: sources,
              metadata: metadata,
            );
          })
          .where((item) => item.text.trim().isNotEmpty)
          .toList();
    } catch (e) {
      throw e is AppException ? e : AppException.unknown(e);
    }
  }

  Future<List<AIChatThread>> getThreads({int limit = 30}) async {
    try {
      final response = await _apiClient.dio.get(
        ApiEndpoints.aiChatThreads,
        queryParameters: {'limit': limit < 1 ? 1 : (limit > 100 ? 100 : limit)},
      );
      final data = response.data;
      if (data is! List) return const <AIChatThread>[];

      return data
          .whereType<Map>()
          .map((raw) => AIChatThread.fromJson(Map<String, dynamic>.from(raw)))
          .where((thread) => thread.id.isNotEmpty)
          .toList(growable: false);
    } catch (e) {
      throw e is AppException ? e : AppException.unknown(e);
    }
  }

  Future<AIChatThread> createThread({String? title, String? productId}) async {
    try {
      final payload = <String, dynamic>{};
      final cleanTitle = title?.trim();
      if (cleanTitle != null && cleanTitle.isNotEmpty) {
        payload['title'] = cleanTitle;
      }
      final safeProductId = productId?.trim();
      if (safeProductId != null && safeProductId.isNotEmpty) {
        payload['productId'] = safeProductId;
      }

      final response = await _apiClient.dio.post(
        ApiEndpoints.aiChatThreads,
        data: payload,
      );
      final data = response.data;
      if (data is Map) {
        final thread = AIChatThread.fromJson(Map<String, dynamic>.from(data));
        if (thread.id.isNotEmpty) return thread;
      }
      throw AppException.unknown('Invalid chat thread response');
    } catch (e) {
      throw e is AppException ? e : AppException.unknown(e);
    }
  }

  Future<void> renameThread({
    required String threadId,
    required String title,
  }) async {
    final safeThreadId = threadId.trim();
    final cleanTitle = title.trim();
    if (safeThreadId.isEmpty || cleanTitle.isEmpty) return;

    try {
      await _apiClient.dio.patch(
        ApiEndpoints.aiChatThread(safeThreadId),
        data: {'title': cleanTitle},
      );
    } catch (e) {
      throw e is AppException ? e : AppException.unknown(e);
    }
  }

  Future<void> archiveThread(String threadId) async {
    final safeThreadId = threadId.trim();
    if (safeThreadId.isEmpty) return;

    try {
      await _apiClient.dio.delete(ApiEndpoints.aiChatThread(safeThreadId));
    } catch (e) {
      throw e is AppException ? e : AppException.unknown(e);
    }
  }

  Future<void> persistAssistantMessage({
    required String message,
    String? threadId,
    String? productId,
    Map<String, dynamic> metadata = const <String, dynamic>{},
    List<String> sources = const <String>[],
  }) async {
    final cleanMessage = message.trim();
    if (cleanMessage.isEmpty) return;

    try {
      final payload = <String, dynamic>{
        'content': cleanMessage,
        'metadata': metadata,
        'sources': sources.take(12).toList(),
        'modelUsed': 'dealio-agent-search',
      };
      final safeThreadId = threadId?.trim();
      if (safeThreadId != null && safeThreadId.isNotEmpty) {
        payload['threadId'] = safeThreadId;
      }
      final safeProductId = productId?.trim();
      if (safeProductId != null && safeProductId.isNotEmpty) {
        payload['productId'] = safeProductId;
      }

      await _apiClient.dio.post(ApiEndpoints.aiChatMessage, data: payload);
    } catch (e) {
      throw e is AppException ? e : AppException.unknown(e);
    }
  }

  Future<void> submitFeedback({
    required String assistantMessage,
    required String userPrompt,
    required bool helpful,
    List<String> sources = const <String>[],
  }) async {
    final cleanAssistantMessage = assistantMessage.trim();
    if (cleanAssistantMessage.isEmpty) return;

    try {
      await _apiClient.dio.post(
        ApiEndpoints.aiChatFeedback,
        data: <String, dynamic>{
          'assistantMessage': cleanAssistantMessage,
          'userPrompt': userPrompt.trim(),
          'helpful': helpful,
          'sources': sources.take(10).toList(),
        },
      );
    } catch (_) {}
  }

  Map<String, dynamic> _extractMetadata(dynamic metadata) {
    if (metadata is! Map) return const <String, dynamic>{};
    return Map<String, dynamic>.from(metadata);
  }

  List<String> _extractSources(dynamic metadata) {
    if (metadata is! Map) return const <String>[];
    final map = Map<String, dynamic>.from(metadata);
    final rawSources = map['sources'];
    if (rawSources is! List) return const <String>[];

    return rawSources
        .map((item) => item.toString().trim())
        .where((item) => item.isNotEmpty)
        .toSet()
        .toList();
  }
}

final aiChatRepositoryProvider = Provider<AIChatRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return AIChatRepository(apiClient);
});
