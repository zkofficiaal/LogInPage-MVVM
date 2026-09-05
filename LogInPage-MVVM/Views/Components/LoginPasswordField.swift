//
//  LoginPasswordField.swift
//  LogInPage-MVVM
//
//  Created by Z.K   on 04/09/2026.
//

import SwiftUI

// MARK: - LoginPasswordField
/// Reusable "label + icon + secure field + eye toggle" component.
/// Used for Password and Confirm Password fields.
struct LoginPasswordField: View {
    let label: String                  // Field label
    let placeholder: String            // Placeholder text
    @Binding var text: String          // Bound text value
    var isFocused: FocusState<LoginView.Field?>.Binding // Focus binding
    let field: LoginView.Field         // Field identifier
    var submitLabel: SubmitLabel = .next
    var onSubmit: () -> Void = {}

    /// Optional trailing accessory (e.g. "Forgot Password?" link).
    var trailingAccessory: AnyView? = nil

    @State private var isSecure: Bool = true // Tracks secure vs plain text

    var body: some View {
        VStack(alignment: .leading, spacing: LoginSpacing.small) {
            HStack {
                Text(label)
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(AppTheme.primaryText)

                Spacer()

                if let trailingAccessory {
                    trailingAccessory
                }
            }

            HStack(spacing: 10) {
                Image(systemName: "lock.fill")
                    .foregroundColor(AppTheme.fieldIcon)
                    .frame(width: 18)

                Group {
                    if isSecure {
                        SecureField("", text: $text, prompt: Text(placeholder)
                            .foregroundColor(AppTheme.fieldPlaceholder))
                    } else {
                        TextField("", text: $text, prompt: Text(placeholder)
                            .foregroundColor(AppTheme.fieldPlaceholder))
                    }
                }
                .foregroundColor(AppTheme.primaryText)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .focused(isFocused, equals: field) // Focus management
                .submitLabel(submitLabel)
                .onSubmit(onSubmit)
                .accessibilityLabel(label)

                Button {
                    withAnimation(.easeInOut(duration: 0.15)) {
                        isSecure.toggle() // Toggle secure/plain text
                    }
                } label: {
                    Image(systemName: isSecure ? "eye.slash.fill" : "eye.fill")
                        .foregroundColor(AppTheme.fieldIcon)
                }
                .accessibilityLabel(isSecure ? "Show password" : "Hide password")
            }
            .padding(.horizontal, 14)
            .frame(height: 50)
            .background(AppTheme.fieldBackground)
            .clipShape(RoundedRectangle(cornerRadius: LoginRadius.field))
        }
    }
}
