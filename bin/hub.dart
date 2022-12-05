import 'package:hub/hub.dart';

void main(List<String> arguments) {
  final admin = Admin();
  final dev = Dev();
  final members = [
    admin,
    dev,
    Dev(),
    Dev(),
  ];
  // ignore: unused_local_variable
  final notificationHub = TeamNotificationHub(client: members);

  admin.sendAll(Welcome('Bonjour'));
  dev.sendTo<Dev>(Welcome('Konnichiwa'));
  admin.sendTo<Dev>(Welcome('Ola'));
}

class Admin with NotificationClient {
  @override
  void receive(Type sender, Message message) {
    if (message is Welcome) {
      print('$runtimeType received from: $sender, message: ${message.value}');
    }
  }
}

class Dev with NotificationClient {
  @override
  void receive(Type sender, Message message) {
    if (message is Welcome) {
      print('$runtimeType received from: $sender, message: ${message.value}');
    }
  }
}

class TeamNotificationHub implements NotificationHub {
  final _clients = <NotificationClient>[];

  TeamNotificationHub({
    List<NotificationClient>? client,
  }) {
    client?.forEach(register);
  }

  @override
  void register(NotificationClient client) {
    client.notificationHub = this;

    _clients.add(client);
  }

  @override
  void sendAll({required NotificationClient sender, required Message message}) {
    final filteredClients = _clients.where((m) => m != sender);

    _sendByFilter(filteredClients, sender.runtimeType, message);
  }

  @override
  void sendTo<T extends NotificationClient>({
    required NotificationClient sender,
    required Message message,
  }) {
    final filteredClients = _clients.where((m) => m != sender).whereType<T>();

    _sendByFilter(filteredClients, sender.runtimeType, message);
  }

  void _sendByFilter(
    Iterable<NotificationClient> filteredClients,
    Type sender,
    covariant Message message,
  ) {
    for (final client in filteredClients) {
      client.receive(sender.runtimeType, message);
    }
  }
}

class Welcome extends Message {
  final String value;

  Welcome(this.value);
}
