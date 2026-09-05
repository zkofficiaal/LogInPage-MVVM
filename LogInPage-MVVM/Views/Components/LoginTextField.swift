//
//  LoginTextField.swift
//  LogInPage-MVVM
//
//  Created by Z.K   on 04/09/2026.
//

import SwiftUI

// MARK: - LoginTextField
/// Reusable "label + icon field" used for text inputs like Email.
struct LoginTextField: View {
    let label: String                  // Field label shown above input
    let placeholder: String            // Placeholder text inside field
    let systemIcon: String             // SF Symbol icon for the field
    @Binding var text: String          // Bound text value
    var keyboardType: UIKeyboardType = .default
    var textContentType: UITextContentType? = nil
    var isFocused: FocusState<LoginView.Field?>.Binding // Focus binding
    let field: LoginView.Field         // Field identifier for focus handling
    var onSubmit: () -> Void = {}      // Action when user submits

    var body: some View {
        VStack(alignment: .leading, spacing: LoginSpacing.small) {
            Text(label)
                .font(.system(size: 13, weight: .semibold))
                .foregroundColor(AppTheme.primaryText)

            HStack(spacing: 10) {
                Image(systemName: systemIcon)
                    .foregroundColor(AppTheme.fieldIcon)
                    .frame(width: 18)

                TextField("", text: $text, prompt: Text(placeholder)
                    .foregroundColor(AppTheme.fieldPlaceholder))
                    .foregroundColor(AppTheme.primaryText)
                    .keyboardType(keyboardType)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .textContentType(textContentType)
                    .focused(isFocused, equals: field) // Focus management
                    .submitLabel(.next)
                    .onSubmit(onSubmit)
                    .accessibilityLabel(label)
            }
            .padding(.horizontal, 14)
            .frame(height: 50)
            .background(AppTheme.fieldBackground)
            .clipShape(RoundedRectangle(cornerRadius: LoginRadius.field))
        }
    }
}
