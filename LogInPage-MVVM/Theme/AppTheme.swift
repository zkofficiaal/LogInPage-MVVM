//
//  AppTheme.swift
//  LogInPage-MVVM
//
//  Created by Z.K   on 04/09/2026.
//

import SwiftUI

// MARK: - AppTheme
/// Centralized color/theme tokens for the Login feature.
/// Components should never hardcode raw values.
enum AppTheme {
    static let background = Color(red: 0.015, green: 0.035, blue: 0.03) // Dark background
    static let accentGreen = Color(red: 0.70, green: 0.95, blue: 0.18)  // Primary accent
    static let onAccentPrimary = Color.black
    static let onAccentSecondary = Color.black.opacity(0.65)
    static let primaryText = Color.white
    static let secondaryText = Color.white.opacity(0.55)
    static let fieldBackground = Color.white.opacity(0.06)
    static let fieldIcon = Color.white.opacity(0.65)
    static let fieldPlaceholder = Color.white.opacity(0.35)
    static let errorText = Color(red: 0.95, green: 0.45, blue: 0.4)      // Validation error
    static let socialChipBackground = Color.white.opacity(0.08)
}

// MARK: - LoginSpacing
/// Centralized spacing tokens to avoid magic numbers.
enum LoginSpacing {
    static let horizontal: CGFloat = 30
    static let small: CGFloat = 8
    static let medium: CGFloat = 14
    static let large: CGFloat = 22
    static let sectionGap: CGFloat = 18
}

// MARK: - LoginRadius
/// Centralized corner radii for consistent UI.
enum LoginRadius {
    static let field: CGFloat = 14
    static let button: CGFloat = 14
}
