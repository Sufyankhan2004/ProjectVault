// ==================== lib/main.dart - COMPLETE ====================
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

// Import providers
import 'providers/app_provider.dart';
import 'providers/auth_provider.dart';
import 'providers/resource_provider.dart';
import 'providers/admin_provider.dart';

// Import screens
import 'screens/splash_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/signup_screen.dart';
import 'screens/auth/forgot_password_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'screens/search/search_screen.dart';
import 'screens/leaderboard/leaderboard_screen.dart';
import 'screens/resource/resource_detail_screen.dart';
import 'screens/resource/upload_resource_screen.dart';
import 'screens/admin/admin_dashboard_screen.dart';
import 'screens/admin/pending_approvals_screen.dart';
import 'screens/admin/manage_sections_screen.dart';
import 'screens/admin/create_section_screen.dart';
import 'screens/admin/manage_users_screen.dart';
import 'screens/admin/analytics_screen.dart';

// Import utils
import 'utils/constants.dart';
import 'utils/theme.dart';
import 'utils/app_routes.dart';
import 'services/local_storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "YOUR_API_KEY",
      appId: "YOUR_APP_ID",
      messagingSenderId: "YOUR_MESSAGING_SENDER_ID",
      projectId: "YOUR_PROJECT_ID",
      storageBucket: "YOUR_STORAGE_BUCKET",
    ),
  );
  
  // Initialize local storage
  await LocalStorageService.init();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ResourceProvider()),
        ChangeNotifierProvider(create: (_) => AdminProvider()),
      ],
      child: Consumer<AppProvider>(
        builder: (context, appProvider, _) {
          return MaterialApp(
            title: AppConstants.appName,
            debugShowCheckedModeBanner: false,
            
            // Theme
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: appProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            
            // Initial Route
            initialRoute: AppRoutes.splash,
            
            // Routes
            routes: {
              // Auth Routes
              AppRoutes.splash: (context) => const SplashScreen(),
              AppRoutes.onboarding: (context) => const OnboardingScreen(),
              AppRoutes.login: (context) => const LoginScreen(),
              AppRoutes.signup: (context) => const SignupScreen(),
              AppRoutes.forgotPassword: (context) => const ForgotPasswordScreen(),
              
              // Main Routes
              AppRoutes.home: (context) => const HomeScreen(),
              AppRoutes.profile: (context) => const ProfileScreen(),
              AppRoutes.search: (context) => const SearchScreen(),
              AppRoutes.leaderboard: (context) => const LeaderboardScreen(),
              
              // Resource Routes
              AppRoutes.resourceDetail: (context) => const ResourceDetailScreen(),
              AppRoutes.uploadResource: (context) => const UploadResourceScreen(),
              
              // Admin Routes
              AppRoutes.adminDashboard: (context) => const AdminDashboardScreen(),
              AppRoutes.pendingApprovals: (context) => const PendingApprovalsScreen(),
              AppRoutes.manageSections: (context) => const ManageSectionsScreen(),
              AppRoutes.createSection: (context) => const CreateSectionScreen(),
              AppRoutes.manageUsers: (context) => const ManageUsersScreen(),
              AppRoutes.analytics: (context) => const AnalyticsScreen(),
            },
            
            // Unknown route
            onUnknownRoute: (settings) {
              return MaterialPageRoute(
                builder: (context) => Scaffold(
                  appBar: AppBar(title: const Text('Error')),
                  body: const Center(
                    child: Text('Page not found'),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}