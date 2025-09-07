import 'package:dartz/dartz.dart';
import 'package:study_box/core/const/app_constant.dart';
import 'package:study_box/feature/auth/data/Services/supabase_auth_service.dart';
import 'package:study_box/feature/auth/data/model/auth_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuthServiceImpl implements SupabaseAuthService {
  final SupabaseClient _supabaseClient = Supabase.instance.client;

  // Sign up new user with email and password
  @override
  Future<Either<String, AuthModel>> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final response = await _supabaseClient.auth.signUp(
        email: email,
        password: password,
        data: {'name': name},
      );

      if (response.user == null) {
        return const Left('Failed to create account');
      }

      // Ensure a profile row exists with email
      await _ensureProfileExists(response.user!);

      final authModel =
          AuthModel.fromUser(response.user!, profile: {'name': name});
      return Right(authModel);
    } on AuthException catch (e) {
      return Left(_getAuthErrorMessage(e));
    } catch (e) {
      return Left('An unexpected error occurred: ${e.toString()}');
    }
  }

  // Sign in with email and password
  @override
  Future<Either<String, AuthModel>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user == null) {
        return const Left('Invalid credentials');
      }

      final profile = await _getUserProfile(response.user!.id);
      final authModel = AuthModel.fromUser(response.user!, profile: profile);
      return Right(authModel);
    } on AuthException catch (e) {
      return Left(_getAuthErrorMessage(e));
    } catch (e) {
      return Left('An unexpected error occurred: ${e.toString()}');
    }
  }

  // Sign in with Google
  @override
  Future<Either<String, AuthModel>> signInWithGoogle() async {
    try {
      final response = await _supabaseClient.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: 'your-app://auth-callback',
      );

      if (!response) {
        return const Left('Google sign-in was cancelled');
      }

      final user = _supabaseClient.auth.currentUser;
      if (user == null) {
        return const Left('Failed to authenticate with Google');
      }

      final profile = await _getUserProfile(user.id);
      final authModel = AuthModel.fromUser(user, profile: profile);
      return Right(authModel);
    } on AuthException catch (e) {
      return Left(_getAuthErrorMessage(e));
    } catch (e) {
      return Left('Google sign-in failed: ${e.toString()}');
    }
  }

  // Sign in with Apple
  @override
  Future<Either<String, AuthModel>> signInWithApple() async {
    try {
      final response = await _supabaseClient.auth.signInWithOAuth(
        OAuthProvider.apple,
        redirectTo: 'your-app://auth-callback',
      );

      if (!response) {
        return const Left('Apple sign-in was cancelled');
      }

      final user = _supabaseClient.auth.currentUser;
      if (user == null) {
        return const Left('Failed to authenticate with Apple');
      }

      final profile = await _getUserProfile(user.id);
      final authModel = AuthModel.fromUser(user, profile: profile);
      return Right(authModel);
    } on AuthException catch (e) {
      return Left(_getAuthErrorMessage(e));
    } catch (e) {
      return Left('Apple sign-in failed: ${e.toString()}');
    }
  }

  // Verify email with token
  @override
  Future<Either<String, String>> verifyEmail({
    required String token,
    String? email,
  }) async {
    try {
      if (email != null && email.isNotEmpty) {
        await _supabaseClient.auth.verifyOTP(
          token: token,
          type: OtpType.signup,
          email: email,
        );
      } else {
        await _supabaseClient.auth.verifyOTP(
          token: token,
          type: OtpType.signup,
        );
      }
      // After successful verification, backfill the profile email if missing
      final currentUser = _supabaseClient.auth.currentUser;
      if (currentUser != null) {
        await _ensureProfileExists(currentUser);
      }
      return const Right('Email verified successfully');
    } on AuthException catch (e) {
      return Left(_getAuthErrorMessage(e));
    } catch (e) {
      return Left('Email verification failed: ${e.toString()}');
    }
  }

  // Resend email verification
  @override
  Future<Either<String, String>> resendEmailVerification(
      {required String email}) async {
    try {
      await _supabaseClient.auth.resend(
        type: OtpType.signup,
        email: email,
      );
      return const Right('Verification email sent successfully');
    } on AuthException catch (e) {
      return Left(_getAuthErrorMessage(e));
    } catch (e) {
      return Left('Failed to send verification email: ${e.toString()}');
    }
  }

  // Send password reset email
  @override
  Future<Either<String, String>> resetPassword({required String email}) async {
    try {
      await _supabaseClient.auth.resetPasswordForEmail(
        email,
        redirectTo: 'your-app://reset-password',
      );
      return const Right('Password reset email sent successfully');
    } on AuthException catch (e) {
      return Left(_getAuthErrorMessage(e));
    } catch (e) {
      return Left('Failed to send password reset email: ${e.toString()}');
    }
  }

  // Update user password
  @override
  Future<Either<String, String>> updatePassword(
      {required String password}) async {
    try {
      await _supabaseClient.auth.updateUser(
        UserAttributes(password: password),
      );
      return const Right('Password updated successfully');
    } on AuthException catch (e) {
      return Left(_getAuthErrorMessage(e));
    } catch (e) {
      return Left('Failed to update password: ${e.toString()}');
    }
  }

  // Get current authenticated user
  @override
  Future<Either<String, AuthModel>> getCurrentUser() async {
    try {
      final user = _supabaseClient.auth.currentUser;
      if (user == null) {
        return const Left('No authenticated user found');
      }

      Map<String, dynamic>? profile = await _getUserProfile(user.id);

      // If there is no profile or email is missing, ensure minimal profile exists
      if (profile == null || profile['email'] == null) {
        await _ensureProfileExists(user);
        profile = await _getUserProfile(user.id) ?? {
          'name': user.userMetadata?['name'] ?? '',
          'email': user.email ?? '',
        };
      }

      final authModel = AuthModel.fromUser(user, profile: profile);
      return Right(authModel);
    } catch (e) {
      return Left('Failed to get current user: ${e.toString()}');
    }
  }

  // Update user profile information
  @override
  Future<Either<String, AuthModel>> updateProfile({
    String? name,
    String? profileImage,
    String? university,
    String? college,
  }) async {
    try {
      final user = _supabaseClient.auth.currentUser;
      if (user == null) {
        return const Left('No authenticated user found');
      }

      final updateData = <String, dynamic>{};
      if (name != null) updateData['name'] = name;
      if (profileImage != null) updateData['profile_image'] = profileImage;
      if (university != null) updateData['university'] = university;
      if (college != null) updateData['college'] = college;

      if (updateData.isNotEmpty) {
        updateData['updated_at'] = DateTime.now().toIso8601String();

        await _supabaseClient.from(AppConstant.tableAuthUsers).upsert({
          'id': user.id,
          'email': user.email,
          ...updateData,
        }).eq('id', user.id);
      }

      final profile = await _getUserProfile(user.id);
      final authModel =
          AuthModel.fromUser(user, profile: profile ?? updateData);
      return Right(authModel);
    } catch (e) {
      return Left('Failed to update profile: ${e.toString()}');
    }
  }

  // Sign out current user
  @override
  Future<Either<String, void>> signOut() async {
    try {
      await _supabaseClient.auth.signOut();
      return const Right(null);
    } on AuthException catch (e) {
      return Left(_getAuthErrorMessage(e));
    } catch (e) {
      return Left('Failed to sign out: ${e.toString()}');
    }
  }

  // Get user profile from database
  Future<Map<String, dynamic>?> _getUserProfile(String userId) async {
    try {
      final response = await _supabaseClient
          .from(AppConstant.tableAuthUsers)
          .select()
          .eq('id', userId)
          .maybeSingle();
      return response;
    } catch (e) {
      return null;
    }
  }

  // Create profile row if missing or missing email
  Future<void> _ensureProfileExists(User user) async {
    try {
      final existing = await _getUserProfile(user.id);
      if (existing == null || existing['email'] == null) {
        final data = {
          'id': user.id,
          'email': user.email,
          'name': user.userMetadata?['name'],
          'created_at': DateTime.now().toIso8601String(),
        }..removeWhere((key, value) => value == null);

        await _supabaseClient.from(AppConstant.tableAuthUsers).upsert(data).eq('id', user.id);
      }
    } catch (_) {
      // Ignore backfill failures; not critical to auth flow
    }
  }

  // Convert AuthException to user-friendly message
  String _getAuthErrorMessage(AuthException error) {
    switch (error.message) {
      case 'Invalid login credentials':
        return 'Invalid email or password';
      case 'Email not confirmed':
        return 'Please verify your email before signing in';
      case 'User already registered':
        return 'An account with this email already exists';
      case 'Password should be at least 6 characters':
        return 'Password must be at least 6 characters long';
      case 'Invalid email':
        return 'Please enter a valid email address';
      case 'Signup disabled':
        return 'New registrations are currently disabled';
      case 'Email rate limit exceeded':
        return 'Too many requests. Please try again later';
      default:
        return error.message;
    }
  }
}
