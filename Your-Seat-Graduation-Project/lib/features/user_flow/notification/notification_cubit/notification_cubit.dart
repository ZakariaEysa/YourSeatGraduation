import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/hive_keys.dart';
import '../../../../data/hive_storage.dart';
import 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial()) {}

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  late String currentUser;

  String _getCurrentUser() {
    final googleUser = HiveStorage.getGoogleUser();
    final defaultUser = HiveStorage.getDefaultUser();

    //print("Role: $role");
    //print("Google email: ${googleUser?.email}");
    //print("Default email: ${defaultUser?.email}");

    if (googleUser != null) {
      return googleUser?.email ?? "";
    } else {
      return defaultUser?.email ?? "";
    }
  }

  static NotificationCubit get(context) =>
      BlocProvider.of<NotificationCubit>(context);

  List<Map<String, String>> allNotifications = [];

  Future<void> initializeNotificationList() async {
    // if (currentUser == null) {
    //   getCurrentUser();
    // }
    currentUser = _getCurrentUser();
    emit(NotificationLoading());
    try {
      final userDoc = firestore.collection('users').doc(currentUser);
      final snapshot = await userDoc.get();

      if (snapshot.exists) {
        final data = snapshot.data()!;
        if (!data.containsKey('notifications')) {
          await userDoc.set({'notifications': []}, SetOptions(merge: true));
        }
        await fetchNotifications();
      } else {
        await userDoc.set({'notifications': []});
        allNotifications = [];
        emit(NotificationLoaded([]));
      }
    } catch (e) {
      emit(NotificationError(e.toString()));
    }
  }

  Future<void> addNotification(
      String titleEn, String bodyEn, String titleAr, String bodyAr) async {
    currentUser = _getCurrentUser();
    try {
      //print("currentUser: $currentUser");
      // if (currentUser == "") {
      //   currentUser = _getCurrentUser();
      // }

      final userDocRef = firestore.collection('users').doc(currentUser);

      final Map<String, dynamic> notification = {
        'title': titleEn,
        'body': bodyEn,
        'title_arb': titleAr,
        'body_arb': bodyAr,
        'timestamp': DateTime.now().toIso8601String(),
      };

      final userSnapshot = await userDocRef.get();

      if (!userSnapshot.exists) {
        await userDocRef.set({
          'notifications': [notification],
        });
      } else {
        final data = userSnapshot.data() ?? {};
        final hasNotifications = data.containsKey('notifications');

        if (hasNotifications) {
          await userDocRef.update({
            'notifications': FieldValue.arrayUnion([notification]),
          });
        } else {
          await userDocRef.update({
            'notifications': [notification],
          });
        }
      }

      await fetchNotifications();
    } catch (e) {
      //print("Error adding notification: $e");
      emit(NotificationError(e.toString()));
    }
  }

  Future<void> removeNotificationAtIndex(int index) async {
    currentUser = _getCurrentUser();
    try {
      // if (currentUser == null) {
      //   getCurrentUser();
      // }
      emit(NotificationLoading());

      final userDoc = firestore.collection('users').doc(currentUser);
      final snapshot = await userDoc.get();

      if (!snapshot.exists) {
        emit(NotificationError("User document does not exist"));
        return;
      }

      final data = snapshot.data();
      final List<dynamic> notifications = data?['notifications'] ?? [];

      if (index < 0 || index >= notifications.length) {
        emit(NotificationError("Invalid notification index"));
        return;
      }

      final notificationToRemove = notifications[index];

      await userDoc.update({
        'notifications': FieldValue.arrayRemove([notificationToRemove])
      });

      // لا نفرغ القائمة، نعيد تحميلها بعد الحذف
      await fetchNotifications();
    } catch (e) {
      emit(NotificationError(e.toString()));
    }
  }

  String getTimeAgo(String timestampString) {
    final timestamp = DateTime.parse(timestampString);
    final now = DateTime.now();
    final difference = now.difference(timestamp);
    final bool isArb = HiveStorage.get(HiveKeys.isArabic) ?? false;

    if (difference.inSeconds < 60) {
      return isArb
          ? 'منذ ${difference.inSeconds} ثانية'
          : '${difference.inSeconds}s ago';
    } else if (difference.inMinutes < 60) {
      return isArb
          ? 'منذ ${difference.inMinutes} دقيقة'
          : '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return isArb
          ? 'منذ ${difference.inHours} ساعة'
          : '${difference.inHours}h ago';
    } else {
      return isArb
          ? 'منذ ${difference.inDays} يوم'
          : '${difference.inDays}d ago';
    }
  }

  Future<void> fetchNotifications() async {
    currentUser = _getCurrentUser();
    // if (currentUser == null) {
    //   getCurrentUser();
    // }
    emit(NotificationLoading());
    try {
      final userDoc =
          await firestore.collection('users').doc(currentUser).get();
      if (userDoc.exists) {
        final data = userDoc.data();
        final List<dynamic> rawList = data?['notifications'] ?? [];

        var notificationsq = rawList.map<Map<String, String>>((e) {
          final map = Map<String, dynamic>.from(e as Map);
          final timestamp = map['timestamp'] ?? '';
          final timeAgo = timestamp.isNotEmpty ? getTimeAgo(timestamp) : '';

          return {
            'title': map['title'] ?? '',
            'body': map['body'] ?? '',
            'title_arb': map['title_arb'] ?? '',
            'body_arb': map['body_arb'] ?? '',
            'timestamp': timestamp,
            'timeAgo': timeAgo,
          };
        }).toList();

        allNotifications = notificationsq;
        emit(NotificationLoaded(allNotifications));
      } else {
        allNotifications = [];
        emit(NotificationLoaded([]));
      }
    } catch (e) {
      emit(NotificationError(e.toString()));
    }
  }
}
