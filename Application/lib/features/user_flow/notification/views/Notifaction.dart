import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../../data/hive_keys.dart';
import '../../../../data/hive_storage.dart';
import '../../../../generated/l10n.dart';
import '../../../../widgets/app_bar/head_appbar.dart';
import '../../../../widgets/loading_indicator.dart';
import '../../../../widgets/scaffold/scaffold_f.dart';
import '../notification_cubit/notification_cubit.dart';
import '../notification_cubit/notification_state.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  // late final NotificationCubit notificationCubit;

  @override
  void initState() {
    super.initState();
    // notificationCubit = NotificationCubit();
    // print(NotificationCubit.get(context).allNotifications.length);

    if (NotificationCubit.get(context).allNotifications.isEmpty) {
      // print("fetching notifications");
      NotificationCubit.get(context).fetchNotifications();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final lang = S.of(context);

    return ScaffoldF(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: theme.colorScheme.onPrimary,
          size: 28.sp,
        ),
        title: HeadAppBar(title: lang.notifications),
      ),
      body: BlocBuilder<NotificationCubit, NotificationState>(
        // bloc: notificationCubit,
        builder: (context, state) {
          if (state is NotificationLoading) {
            return const LoadingIndicator();
          } else if (state is NotificationError) {
            return Center(child: Text('Error: ${state.message}'));
          } else if (state is NotificationLoaded) {
            final notifications = state.notifications;

            if (notifications.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/icons/no_notification_icon.png",
                      width: 100,
                      height: 100,
                    ),
                    SizedBox(height: 20),
                    Text(
                      lang.noNotificationsYet,
                      style:
                          theme.textTheme.bodyLarge?.copyWith(fontSize: 18.sp),
                    ),
                  ],
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.only(top: 50, left: 10, right: 15),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final isArabic = HiveStorage.get(HiveKeys.isArabic) ?? false;
                final notification = notifications[index];

                final title = isArabic
                    ? notification['title_arb'] ?? 'No Title'
                    : notification['title'] ?? 'No Title';

                final body = isArabic
                    ? notification['body_arb'] ?? 'No Body'
                    : notification['body'] ?? 'No Body';

                final time = notification['timeAgo'] ?? 'No Time';

                return NotificationCard(
                  index: index,
                  title: title,
                  body: body,
                  time: time,
                  onDelete: (i) async {
                    await NotificationCubit.get(context)
                        .removeNotificationAtIndex(i);
                  },
                );
              },
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final String title;
  final String body;
  final String time;
  final int index;
  final void Function(int index)? onDelete;

  const NotificationCard({
    super.key,
    required this.title,
    required this.body,
    required this.time,
    required this.index,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      child: Slidable(
        key: ValueKey(index),
        startActionPane: ActionPane(
          extentRatio: 0.4,
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: (_) => onDelete?.call(index),
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: "Delete",
              borderRadius: BorderRadius.circular(12),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF877AA7),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      body,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                time,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
