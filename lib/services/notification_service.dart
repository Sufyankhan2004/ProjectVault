// ==================== lib/services/notification_service.dart ====================
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  // final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  // final FlutterLocalNotificationsPlugin _localNotifications = FlutterLocalNotificationsPlugin();
  
  // Initialize
  Future<void> initialize() async {
    // Request permission
    // await _requestPermission();
    
    // Initialize local notifications
    // await _initializeLocalNotifications();
    
    // Get FCM token
    // final token = await _messaging.getToken();
    // print('FCM Token: $token');
    
    // Listen to messages
    // FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
    // FirebaseMessaging.onMessageOpenedApp.listen(_handleBackgroundMessage);
  }
  
  // Request permission
  Future<void> _requestPermission() async {
    // final settings = await _messaging.requestPermission(
    //   alert: true,
    //   badge: true,
    //   sound: true,
    // );
    // print('Permission status: ${settings.authorizationStatus}');
  }
  
  // Initialize local notifications
  Future<void> _initializeLocalNotifications() async {
    // const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    // const ios = DarwinInitializationSettings();
    // const settings = InitializationSettings(android: android, iOS: ios);
    
    // await _localNotifications.initialize(
    //   settings,
    //   onDidReceiveNotificationResponse: _onNotificationTapped,
    // );
  }
  
  // Show local notification
  Future<void> showNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    // const android = AndroidNotificationDetails(
    //   'projectvault_channel',
    //   'ProjectVault Notifications',
    //   importance: Importance.high,
    //   priority: Priority.high,
    // );
    
    // const ios = DarwinNotificationDetails();
    // const details = NotificationDetails(android: android, iOS: ios);
    
    // await _localNotifications.show(
    //   DateTime.now().millisecond,
    //   title,
    //   body,
    //   details,
    //   payload: payload,
    // );
  }
  
  // Handle foreground message
  void _handleForegroundMessage(dynamic message) {
    print('Foreground message: ${message.notification?.title}');
    // Show local notification
  }
  
  // Handle background message
  void _handleBackgroundMessage(dynamic message) {
    print('Background message: ${message.notification?.title}');
    // Navigate to relevant screen
  }
  
  // Handle notification tap
  void _onNotificationTapped(dynamic response) {
    print('Notification tapped: ${response.payload}');
    // Navigate to relevant screen
  }
  
  // Send notification to user
  Future<void> sendNotificationToUser({
    required String userId,
    required String title,
    required String body,
    String? resourceId,
  }) async {
    // This would typically be done from backend
    // But you can use Cloud Functions or your own backend
  }
}