import 'package:dartz/dartz.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:study_box/core/const/app_constant.dart';
import 'package:study_box/core/error/failure.dart';
import 'package:study_box/core/localization/localization_manager.dart';
import 'package:study_box/feature/auth/data/Services/supabase_auth_service.dart';
import 'package:study_box/feature/auth/data/model/auth_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuthServiceImpl implements SupabaseAuthService {
  final SupabaseClient _supabaseClient = Supabase.instance.client;

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
    clientId: AppConstant.appleClientID,
    serverClientId: AppConstant.webClientID,
  );

  SupabaseAuthServiceImpl();

  @override
  Future<Either<Failure, AuthModel>> signUp({
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
        return Left(
          ServerFailure(
              message: LocalizationManager.l.failed_to_create_account),
        );
      }

      await _ensureProfileExists(response.user!);
      await _ensureSubscriptionRow(response.user!.id);

      final authModel =
          AuthModel.fromUser(response.user!, profile: {'name': name});
      return Right(authModel);
    } on AuthException catch (e) {
      return Left(ServerFailure(message: _getAuthErrorMessage(e)));
    } catch (e) {
      return Left(
        ServerFailure(message: LocalizationManager.l.unexpected_error_occurred),
      );
    }
  }

  @override
  Future<Either<Failure, AuthModel>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user == null) {
        return Left(
          ServerFailure(message: LocalizationManager.l.invalid_credentials),
        );
      }

      await _ensureSubscriptionRow(response.user!.id);
      final profile = await _getUserProfile(response.user!.id);
      final authModel = AuthModel.fromUser(response.user!, profile: profile);
      return Right(authModel);
    } on AuthException catch (e) {
      return Left(ServerFailure(message: _getAuthErrorMessage(e)));
    } catch (e) {
      return Left(
        ServerFailure(message: LocalizationManager.l.unexpected_error_occurred),
      );
    }
  }

  @override
  Future<Either<Failure, AuthModel>> signInWithGoogle() async {
    try {
      await _googleSignIn.signOut();

      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return Left(
          ServerFailure(message: LocalizationManager.l.google_signin_cancelled),
        );
      }

      final googleAuth = await googleUser.authentication;

      final response = await _supabaseClient.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: googleAuth.idToken!,
        accessToken: googleAuth.accessToken,
      );

      if (response.user == null) {
        return Left(
          ServerFailure(
              message: LocalizationManager.l.failed_authenticate_google),
        );
      }

      await _ensureProfileExists(response.user!);
      await _ensureSubscriptionRow(response.user!.id);
      final profile = await _getUserProfile(response.user!.id);
      final authModel = AuthModel.fromUser(response.user!, profile: profile);
      return Right(authModel);
    } on AuthException catch (e) {
      return Left(ServerFailure(message: _getAuthErrorMessage(e)));
    } catch (e) {
      return Left(
        ServerFailure(message: LocalizationManager.l.google_signin_failed),
      );
    }
  }

  @override
  Future<Either<Failure, AuthModel>> signInWithApple() async {
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName
        ],
      );

      final response = await _supabaseClient.auth.signInWithIdToken(
        provider: OAuthProvider.apple,
        idToken: appleCredential.identityToken!,
      );

      if (response.user == null) {
        return Left(
          ServerFailure(
              message: LocalizationManager.l.failed_authenticate_apple),
        );
      }

      await _ensureProfileExists(response.user!);
      await _ensureSubscriptionRow(response.user!.id);
      final profile = await _getUserProfile(response.user!.id);
      final authModel = AuthModel.fromUser(response.user!, profile: profile);
      return Right(authModel);
    } on AuthException catch (e) {
      return Left(ServerFailure(message: _getAuthErrorMessage(e)));
    } catch (e) {
      return Left(
        ServerFailure(message: LocalizationManager.l.apple_signin_failed),
      );
    }
  }

  @override
  Future<Either<Failure, String>> verifyEmail({
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

      final currentUser = _supabaseClient.auth.currentUser;
      if (currentUser != null) {
        await _ensureProfileExists(currentUser);
        await _ensureSubscriptionRow(currentUser.id);
      }
      return Right(LocalizationManager.l.email_verified_successfully);
    } on AuthException catch (e) {
      return Left(ServerFailure(message: _getAuthErrorMessage(e)));
    } catch (e) {
      return Left(
        ServerFailure(message: LocalizationManager.l.email_verification_failed),
      );
    }
  }

  @override
  Future<Either<Failure, String>> verifyPasswordReset({
    required String token,
    String? email,
  }) async {
    try {
      if (email != null && email.isNotEmpty) {
        await _supabaseClient.auth.verifyOTP(
          token: token,
          type: OtpType.recovery,
          email: email,
        );
      } else {
        await _supabaseClient.auth.verifyOTP(
          token: token,
          type: OtpType.recovery,
        );
      }

      return Right(LocalizationManager.l.password_reset_verified_successfully);
    } on AuthException catch (e) {
      return Left(ServerFailure(message: _getAuthErrorMessage(e)));
    } catch (e) {
      return Left(
        ServerFailure(
            message: LocalizationManager.l.password_reset_verification_failed),
      );
    }
  }

  @override
  Future<Either<Failure, String>> resendEmailVerification(
      {required String email}) async {
    try {
      await _supabaseClient.auth.resend(
        type: OtpType.signup,
        email: email,
      );
      return Right(LocalizationManager.l.verification_email_sent_successfully);
    } on AuthException catch (e) {
      return Left(ServerFailure(message: _getAuthErrorMessage(e)));
    } catch (e) {
      return Left(
        ServerFailure(
            message: LocalizationManager.l.failed_send_verification_email),
      );
    }
  }

  @override
  Future<Either<Failure, String>> resetPassword({required String email}) async {
    try {
      await _supabaseClient.auth.resetPasswordForEmail(
        email,
        redirectTo: 'your-app://reset-password',
      );
      return Right(
          LocalizationManager.l.password_reset_email_sent_successfully);
    } on AuthException catch (e) {
      return Left(ServerFailure(message: _getAuthErrorMessage(e)));
    } catch (e) {
      return Left(
        ServerFailure(
            message: LocalizationManager.l.failed_send_password_reset_email),
      );
    }
  }

  @override
  Future<Either<Failure, String>> updatePassword(
      {required String password}) async {
    try {
      await _supabaseClient.auth.updateUser(
        UserAttributes(password: password),
      );
      return Right(LocalizationManager.l.password_updated_successfully);
    } on AuthException catch (e) {
      return Left(ServerFailure(message: _getAuthErrorMessage(e)));
    } catch (e) {
      return Left(
        ServerFailure(message: LocalizationManager.l.failed_update_password),
      );
    }
  }

  @override
  Future<Either<Failure, AuthModel>> getCurrentUser() async {
    try {
      final user = _supabaseClient.auth.currentUser;
      if (user == null) {
        return Left(
          ServerFailure(
              message: LocalizationManager.l.no_authenticated_user_found),
        );
      }

      Map<String, dynamic>? profile = await _getUserProfile(user.id);

      if (profile == null || profile['email'] == null) {
        await _ensureProfileExists(user);
        profile = await _getUserProfile(user.id) ??
            {
              'name': user.userMetadata?['name'] ?? '',
              'email': user.email ?? '',
            };
      }

      await _ensureSubscriptionRow(user.id);

      final authModel = AuthModel.fromUser(user, profile: profile);
      return Right(authModel);
    } catch (e) {
      return Left(
        ServerFailure(message: LocalizationManager.l.failed_get_current_user),
      );
    }
  }

  @override
  Future<Either<Failure, AuthModel>> updateProfile({
    String? name,
    String? profileImage,
    String? university,
    String? college,
  }) async {
    try {
      final user = _supabaseClient.auth.currentUser;
      if (user == null) {
        return Left(
          ServerFailure(
              message: LocalizationManager.l.no_authenticated_user_found),
        );
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
      return Left(
        ServerFailure(message: LocalizationManager.l.failed_update_profile),
      );
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await _supabaseClient.auth.signOut();
      return const Right(null);
    } on AuthException catch (e) {
      return Left(ServerFailure(message: _getAuthErrorMessage(e)));
    } catch (e) {
      return Left(
        ServerFailure(message: LocalizationManager.l.failed_sign_out),
      );
    }
  }

  // Helper methods (same as before)
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

        await _supabaseClient
            .from(AppConstant.tableAuthUsers)
            .upsert(data)
            .eq('id', user.id);
      }
    } catch (_) {
      // Ignore backfill failures; not critical to auth flow
    }
  }

  Future<void> _ensureSubscriptionRow(String userId) async {
    try {
      final existing = await _supabaseClient
          .from(AppConstant.subscriptionTable)
          .select('id')
          .eq('id', userId)
          .maybeSingle();
      if (existing == null) {
        await _supabaseClient
            .from(AppConstant.subscriptionTable)
            .upsert({
              'id': userId,
              'subscription_tier': 'free',
              'created_at': DateTime.now().toIso8601String(),
              'updated_at': DateTime.now().toIso8601String(),
            })
            .select();
      }
    } catch (_) {
      // If RLS denies, ignore; app will treat as free in reads
    }
  }

  String _getAuthErrorMessage(AuthException error) {
    switch (error.message) {
      case 'Invalid login credentials':
        return LocalizationManager.l.invalid_login_credentials;
      case 'Email not confirmed':
        return LocalizationManager.l.email_not_confirmed;
      case 'User already registered':
        return LocalizationManager.l.user_already_registered;
      case 'Password should be at least 6 characters':
        return LocalizationManager.l.password_min_length;
      case 'Invalid email':
        return LocalizationManager.l.invalid_email;
      case 'Signup disabled':
        return LocalizationManager.l.signup_disabled;
      case 'Email rate limit exceeded':
        return LocalizationManager.l.email_rate_limit_exceeded;
      case 'Token has expired':
      case 'Invalid token':
      case 'Token expired':
        return LocalizationManager.l.verification_code_expired;
      case 'Invalid OTP':
      case 'Token not found':
        return LocalizationManager.l.invalid_verification_code;
      default:
        if (error.message.toLowerCase().contains('expired') ||
            error.message.toLowerCase().contains('invalid token') ||
            error.message.toLowerCase().contains('token not found')) {
          return LocalizationManager.l.verification_code_expired;
        }
        return error.message;
    }
  }
}
