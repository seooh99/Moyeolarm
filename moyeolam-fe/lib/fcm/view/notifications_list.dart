import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/api_service.dart';
import '../viewmodel/notification_viewmodel.dart';


class NotificationsList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationsAsyncValue = ref.watch(notificationsProvider);

    return notificationsAsyncValue.when(
      loading: () => CircularProgressIndicator(),
      error: (err, stack) => Text('Error: $err'),
      data: (data) {
        return ListView.builder(
          ///notificationsProvider의 정의와 NotificationsList 클래스의 구현을 기준으로, notificationsProvider는 List<Alert> 타입의 미래값을 제공
          itemCount: data.length,
          itemBuilder: (context, index) {
            final notification = data[index];
            return ListTile(
              title: Text('${notification.fromNickname} 님이 ${notification.alertType}'),
            );
          },
        );
      },
    );
  }
}
