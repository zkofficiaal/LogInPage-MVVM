//
//  LoginView.swift
//  LogInPage-MVVM
//
//  Created by Z.K   on 04/09/2026.
//

import SwiftUI

// MARK: - LoginView
struct LoginView: View {
    enum Field: Hashable {
        case email
        case password
        case confirmPassword
    }

    @StateObject private var viewModel = LoginViewModel() // ViewModel binding
    @FocusState private var focusedField: Field?          // Tracks focused input

    var body: some View {
        ZStack {
            AppTheme.background.ignoresSafeArea()

            ScrollView {
                VStack(spacing: 0) {
                    LoginHeaderView()

                    VStack(spacing: LoginSpacing.sectionGap) {
                        formFields
                        primaryButton

                        if viewModel.isCreateAccountMode {
                            backToLoginButton
                        } else {
                            LoginDividerView()
                            socialButtons
                            createAccountRow
                        }

                        LoginFooterView(
                            onPrivacyTap: viewModel.openPrivacy,
                            onTermsTap: viewModel.openTerms
                        )
                        .padding(.top, LoginSpacing.small)
                        .padding(.bottom, LoginSpacing.large)
                    }
                    .padding(.horizontal, LoginSpacing.horizontal)
                    .padding(.top, LoginSpacing.large)
                }
            }
            .scrollDismissesKeyboard(.interactively)
        }
        // Error alert
        .alert("Something's not right", isPresented: $viewModel.showError, presenting: viewModel.errorMessage) { _ in
            Button("OK", role: .cancel) {}
        } message: { message in
            Text(message)
        }
        // Placeholder sheets
        .sheet(isPresented: $viewModel.showForgotPasswordSheet) {
            PlaceholderSheet(title: "Forgot Password", message: "Password reset isn't wired to a backend yet — this is a placeholder.")
        }
        .sheet(isPresented: $viewModel.showPrivacySheet) {
            PlaceholderSheet(title: "Privacy Policy", message: "Your privacy policy content goes here.")
        }
        .sheet(isPresented: $viewModel.showTermsSheet) {
            PlaceholderSheet(title: "Terms of Service", message: "Your terms of service content goes here.")
        }
    }

    // MARK: - Form
    @ViewBuilder
    private var formFields: some View {
        LoginTextField(
            label: "Email",
            placeholder: "Enter your email",
            systemIcon: "envelope.fill",
            text: $viewModel.email,
            keyboardType: .emailAddress,
            textContentType: .emailAddress,
            isFocused: $focusedField,
            field: .email,
            onSubmit: { focusedField = .password }
        )

        LoginPasswordField(
            label: "Password",
            placeholder: "Enter your password",
            text: $viewModel.password,
            isFocused: $focusedField,
            field: .password,
            submitLabel: viewModel.isCreateAccountMode ? .next : .done,
            onSubmit: {
                if viewModel.isCreateAccountMode {
                    focusedField = .confirmPassword
                } else {
                    focusedField = nil
                }
            },
            trailingAccessory: viewModel.isCreateAccountMode ? nil : AnyView(forgotPasswordLink)
        )

        if viewModel.isCreateAccountMode {
            LoginPasswordField(
                label: "Confirm Password",
                placeholder: "Confirm your password",
                text: $viewModel.confirmPassword,
                isFocused: $focusedField,
                field: .confirmPassword,
                submitLabel: .done,
                onSubmit: { focusedField = nil }
            )
            .transition(.opacity.combined(with: .move(edge: .top)))
        }
    }

    private var forgotPasswordLink: some View {
        Button(action: viewModel.forgotPassword) {
            Text("Forgot Password?")
                .font(.system(size: 11, weight: .semibold))
                .foregroundColor(AppTheme.accentGreen)
        }
        .accessibilityLabel("Forgot password")
    }

    // MARK: - Primary button
    private var primaryButton: some View {
        Button {
            focusedField = nil
            if viewModel.isCreateAccountMode {
                viewModel.submitRegistration()
            } else {
                viewModel.signIn()
            }
        } label: {
            ZStack {
                if viewModel.isLoading {
                    ProgressView()
                        .tint(.black)
                } else {
                    Text(viewModel.isCreateAccountMode ? "Create Account" : "Sign In")
                        .font(.system(size: 16, weight: .semibold))
                }
            }
            .foregroundColor(.black)
            .frame(maxWidth: .infinity)
            .frame(height: 54)
            .background(AppTheme.accentGreen)
            .clipShape(RoundedRectangle(cornerRadius: LoginRadius.button))
        }
        .disabled(viewModel.isLoading)
        .accessibilityLabel(viewModel.isCreateAccountMode ? "Create account" : "Sign in")
    }

    private var backToLoginButton: some View {
        Button(action: viewModel.returnToLogin) {
            Text("Already have an account? ")
                .foregroundColor(AppTheme.secondaryText)
            + Text("Sign In")
                .foregroundColor(AppTheme.accentGreen)
        }
        .font(.system(size: 12, weight: .medium))
        .accessibilityLabel("Return to sign in")
    }

    // MARK: - Social
    private var socialButtons: some View {
        HStack(spacing: 12) {
            SocialLoginButton(provider: .google, action: viewModel.signInWithGoogle)
            SocialLoginButton(provider: .apple, action: viewModel.signInWithApple)
            SocialLoginButton(provider: .facebook, action: viewModel.signInWithFacebook)
        }
    }

    // MARK: - Create account row
    private var createAccountRow: some View {
        Button(action: viewModel.createAccount) {
            Text("Don't have an account? ")
                .foregroundColor(AppTheme.secondaryText)
            + Text("Create Account")
                .foregroundColor(AppTheme.accentGreen)
        }
        .font(.system(size: 12, weight: .medium))
        .accessibilityLabel("Create account")
    }
}

// MARK: - PlaceholderSheet
/// Minimal placeholder sheet used for Forgot Password / Privacy / Terms
/// until real content/backends exist.
private struct PlaceholderSheet: View {
    let title: String
    let message: String
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Text(message)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding()
                Spacer()
            }
            .padding(.top, 40)
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") { dismiss() }
                }
            }
        }
        .presentationDetents([.medium])
    }
}

#Preview {
    LoginView()
}
