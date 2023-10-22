
class SocketActionRecord {
  final String event_id;
  bool is_validated;
  int replies;
  final void Function() callback;
  SocketActionRecord({
    required this.event_id,
    required this.callback,
    this.is_validated = false,
    this.replies = 0
  });
}