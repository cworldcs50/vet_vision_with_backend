enum MessageRole { user, ai }

class ChatMessage {
  final String id;
  String text; // mutable so streaming can append
  final MessageRole role;
  final DateTime timestamp;

  ChatMessage({
    required this.id,
    required this.text,
    required this.role,
    required this.timestamp,
  });

  factory ChatMessage.user(String text) => ChatMessage(
        id: 'user_${DateTime.now().millisecondsSinceEpoch}',
        text: text,
        role: MessageRole.user,
        timestamp: DateTime.now(),
      );

  factory ChatMessage.ai(String text) => ChatMessage(
        id: 'ai_${DateTime.now().millisecondsSinceEpoch}',
        text: text,
        role: MessageRole.ai,
        timestamp: DateTime.now(),
      );
}
