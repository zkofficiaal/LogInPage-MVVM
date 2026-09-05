//
//  AuthenticationService.swift
//  LogInPage-MVVM
//
//  Created by Z.K   on 04/09/2026.
//
import Foundation

// MARK: - AuthenticationService
/// Abstraction over authentication so the ViewModel never talks to a
/// concrete backend directly. Swap `MockAuthenticationService` for a real
/// Firebase/REST-backed implementation later without touching the View or ViewModel.
protocol AuthenticationService {
    func login(email: String, password: String) async throws      // Email/password login
    func register(email: String, password: String) async throws   // Email/password registration
    func loginWithGoogle() async throws                          // Google sign-in
    func loginWithApple() async throws                           // Apple sign-in
    func loginWithFacebook() async throws                        // Facebook sign-in
}

// MARK: - MockAuthenticationService
/// Mock implementation used until a real backend is wired up.
/// Simulates network latency so the loading state in the UI can be exercised end to end.
final class MockAuthenticationService: AuthenticationService {
    func login(email: String, password: String) async throws {
        try await Task.sleep(nanoseconds: 900_000_000) // Simulated delay
    }

    func register(email: String, password: String) async throws {
        try await Task.sleep(nanoseconds: 900_000_000)
    }

    func loginWithGoogle() async throws {
        try await Task.sleep(nanoseconds: 600_000_000)
    }

    func loginWithApple() async throws {
        try await Task.sleep(nanoseconds: 600_000_000)
    }

    func loginWithFacebook() async throws {
        try await Task.sleep(nanoseconds: 600_000_000)
    }
}

