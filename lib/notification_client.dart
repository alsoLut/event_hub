import 'package:meta/meta.dart';

import 'base_notification_client.dart';
import 'message.dart';
import 'notification_hub.dart';

typedef Any = NotificationClient;

abstract class NotificationClient implements BaseNotificationClient {
  @nonVirtual
  NotificationHub? notificationHub;

  void receive(Type sender, Message message);

  @override
  @nonVirtual
  void sendAll(Message message) {
    _assertHubNotNull();
    notificationHub?.sendAll(
      sender: this,
      message: message,
    );
  }

  @override
  @nonVirtual
  void sendTo<T extends NotificationClient>(Message message) {
    _assertHubNotNull();
    notificationHub?.sendTo<T>(
      sender: this,
      message: message,
    );
  }

  _assertHubNotNull() {
    assert(notificationHub != null, 'notificationHub must not be null');
  }
}
