//
//  LoginFooterView.swift
//  LogInPage-MVVM
//
//  Created by Z.K   on 04/09/2026.
//

import SwiftUI

// MARK: - LoginFooterView
/// Footer with Privacy and Terms links.
struct LoginFooterView: View {
    var onPrivacyTap: () -> Void   // Action when Privacy tapped
    var onTermsTap: () -> Void     // Action when Terms tapped

    var body: some View {
        HStack(spacing: 28) {
            Button(action: onPrivacyTap) {
                HStack(spacing: 5) {
                    Image(systemName: "checkmark.shield")
                        .font(.system(size: 11))
                    Text("Privacy")
                        .font(.system(size: 11, weight: .medium))
                }
            }
            .accessibilityLabel("Privacy policy")

            Button(action: onTermsTap) {
                HStack(spacing: 5) {
                    Image(systemName: "doc.text")
                        .font(.system(size: 11))
                    Text("Terms")
                        .font(.system(size: 11, weight: .medium))
                }
            }
            .accessibilityLabel("Terms of service")
        }
        .foregroundColor(AppTheme.secondaryText) // Consistent theme color
    }
}
