//
//  LoginViewModel.swift
//  LogInPage-MVVM
//
//  Created by Z.K   on 04/09/2026.
//

import SwiftUI
import Combine

@MainActor
final class LoginViewModel: ObservableObject {

    // MARK: - Form state
    @Published var email: String = ""            // User's email input
    @Published var password: String = ""         // User's password input
    @Published var confirmPassword: String = ""  // Confirm password (registration only)

    // MARK: - Mode
    /// false = Login mode (Email, Password, Forgot Password, Sign In)
    /// true  = Registration mode (Email, Password, Confirm Password, Create Account)
    @Published var isCreateAccountMode: Bool = false

    // MARK: - UI state
    @Published var isLoading: Bool = false       // Tracks async operation state
    @Published var errorMessage: String?         // Holds error text for UI
    @Published var showError: Bool = false       // Toggles error alert visibility

    @Published var showForgotPasswordSheet: Bool = false // Forgot password sheet toggle
    @Published var showPrivacySheet: Bool = false        // Privacy sheet toggle
    @Published var showTermsSheet: Bool = false          // Terms sheet toggle

    private let authService: AuthenticationService // Dependency for authentication

    init(authService: AuthenticationService = MockAuthenticationService()) {
        self.authService = authService
    }

    // MARK: - Validation
    /// Checks email format against regex.
    private func isValidEmail(_ email: String) -> Bool {
        let regex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        return email.range(of: regex, options: .regularExpression) != nil
    }

    /// Validates login form fields.
    private func validateLogin() -> String? {
        if email.trimmingCharacters(in: .whitespaces).isEmpty {
            return "Please enter your email address."
        }
        if !isValidEmail(email) {
            return "Please enter a valid email address."
        }
        if password.isEmpty {
            return "Please enter your password."
        }
        if password.count < 6 {
            return "Password must be at least 6 characters."
        }
        return nil
    }

    /// Validates registration form fields.
    private func validateRegistration() -> String? {
        if let baseError = validateLogin() {
            return baseError
        }
        if confirmPassword.isEmpty {
            return "Please confirm your password."
        }
        if confirmPassword != password {
            return "Passwords do not match."
        }
        return nil
    }

    // MARK: - Actions — Login
    /// Attempts to sign in with email/password.
    func signIn() {
        if let validationError = validateLogin() {
            present(error: validationError)
            return
        }

        Task {
            isLoading = true
            defer { isLoading = false }
            do {
                try await authService.login(email: email, password: password)
            } catch {
                present(error: "Unable to sign in. Please try again.")
            }
        }
    }

    // MARK: - Actions — Registration
    /// Switches form into registration mode.
    func createAccount() {
        withAnimation(.easeInOut(duration: 0.2)) {
            isCreateAccountMode = true
        }
    }

    /// Submits registration form.
    func submitRegistration() {
        if let validationError = validateRegistration() {
            present(error: validationError)
            return
        }

        Task {
            isLoading = true
            defer { isLoading = false }
            do {
                try await authService.register(email: email, password: password)
            } catch {
                present(error: "Unable to create your account. Please try again.")
            }
        }
    }

    /// Returns to login mode from registration.
    func returnToLogin() {
        withAnimation(.easeInOut(duration: 0.2)) {
            isCreateAccountMode = false
        }
        confirmPassword = ""
        errorMessage = nil
        showError = false
    }

    // MARK: - Actions — Forgot password
    func forgotPassword() {
        showForgotPasswordSheet = true
    }

    // MARK: - Actions — Social
    /// Google sign-in flow.
    func signInWithGoogle() {
        Task {
            isLoading = true
            defer { isLoading = false }
            do {
                try await authService.loginWithGoogle()
            } catch {
                present(error: "Google sign-in failed. Please try again.")
            }
        }
    }

    /// Apple sign-in flow.
    func signInWithApple() {
        Task {
            isLoading = true
            defer { isLoading = false }
            do {
                try await authService.loginWithApple()
            } catch {
                present(error: "Apple sign-in failed. Please try again.")
            }
        }
    }

    /// Facebook sign-in flow.
    func signInWithFacebook() {
        Task {
            isLoading = true
            defer { isLoading = false }
            do {
                try await authService.loginWithFacebook()
            } catch {
                present(error: "Facebook sign-in failed. Please try again.")
            }
        }
    }

    // MARK: - Actions — Footer
    func openPrivacy() {
        showPrivacySheet = true
    }

    func openTerms() {
        showTermsSheet = true
    }

    // MARK: - Helpers
    /// Presents error message in UI.
    private func present(error message: String) {
        errorMessage = message
        showError = true
    }
}
