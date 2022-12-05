import 'message.dart';
import 'notification_client.dart';

abstract class BaseNotificationClient {
  void sendAll(Message message);
  void sendTo<T extends NotificationClient>(Message message);
}
