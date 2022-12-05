import 'message.dart';
import 'notification_client.dart';

abstract class NotificationHub {
  void register(NotificationClient client);

  void sendAll({
    required NotificationClient sender,
    required Message message,
  });

  void sendTo<T extends NotificationClient>({
    required NotificationClient sender,
    required Message message,
  });
}
