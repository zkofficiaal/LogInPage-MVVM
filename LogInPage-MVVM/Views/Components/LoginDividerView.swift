//
//  LoginDividerView.swift
//  LogInPage-MVVM
//
//  Created by Z.K   on 04/09/2026.
//

import SwiftUI

// MARK: - LoginDividerView
/// "OR CONTINUE WITH" divider between the primary action and social logins.
struct LoginDividerView: View {
    var text: String = "OR CONTINUE WITH" // Divider text

    var body: some View {
        Text(text)
            .font(.system(size: 11, weight: .semibold))
            .foregroundColor(AppTheme.secondaryText)
            .tracking(0.5) // Slight letter spacing for readability
    }
}
