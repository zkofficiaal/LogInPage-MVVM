<img width="383" height="779" alt="Screenshot 2026-09-04 at 11 08 36 PM" src="https://github.com/user-attachments/assets/6a9369bd-1988-4b60-b93b-1d027e178b2d" />
<img width="388" height="774" alt="Screenshot 2026-09-04 at 11 08 53 PM" src="https://github.com/user-attachments/assets/be7ac472-f301-431c-b454-1c50884b0c4d" />

# LogInPage-MVVM

A SwiftUI login/registration screen built with MVVM, matching a neon-green
fintech-style reference design. Includes a custom wave-shaped header, full
field validation, mock authentication, and a Create Account flow.

## Structure

```
LogInPage-MVVM/
│
├── Theme/
│   └── AppTheme.swift            # Colors, spacing, and corner-radius tokens
│
├── Models/
│   └── LoginModel.swift          # Simple email/password value type
│
├── ViewModels/
│   └── LoginViewModel.swift      # All state, validation, and auth actions
│
├── Views/
│   ├── LoginView.swift           # Screen composition + keyboard/focus handling
│   └── Components/
│       ├── LoginHeaderView.swift        # Wave header, logo, title, subtitle
│       ├── LoginHeaderWaveShape.swift    # Custom organic wave Shape
│       ├── LoginTextField.swift         # Reusable icon + text field (Email)
│       ├── LoginPasswordField.swift     # Reusable icon + secure field with eye toggle
│       ├── SocialLoginButton.swift      # Google / Apple / Facebook chip
│       ├── LoginDividerView.swift       # "OR CONTINUE WITH" divider
│       └── LoginFooterView.swift        # Privacy / Terms links
│
└── Services/
    └── AuthenticationService.swift  # Protocol + MockAuthenticationService
```

## How it works

- **MVVM boundaries.** `LoginView` never validates or calls auth directly —
  every action (`signIn()`, `createAccount()`, `signInWithGoogle()`, etc.)
  lives on `LoginViewModel`. The View only reads `@Published` state and
  forwards taps.
- **Two modes, one screen.** `LoginViewModel.isCreateAccountMode` toggles
  between:
  - **Login:** Email, Password, Forgot Password, Sign In, social buttons,
    "Create Account" link.
  - **Registration:** Email, Password, Confirm Password, Create Account
    button, "Sign In" link back to login. The Confirm Password field
    animates in/out and is only present in this mode.
- **Validation** lives entirely in the ViewModel: email format, password
  length, and (in registration mode) that Confirm Password matches. Errors
  surface through a single `errorMessage` / `showError` pair, shown as an
  alert.
- **Auth service** is a protocol (`AuthenticationService`) with a
  `MockAuthenticationService` that just sleeps briefly to simulate network
  latency. Swap in a real implementation later without touching the View or
  ViewModel.
- **Focus & keyboard.** `LoginView.Field` (`.email`, `.password`,
  `.confirmPassword`) drives `@FocusState`, so Return/Next moves between
  fields correctly in both modes, and the form sits in a `ScrollView` so the
  Sign In / Create Account button never gets stuck behind the keyboard.
- **Theming.** All colors, spacing, and radii are defined once in
  `AppTheme.swift` — no raw color literals scattered through the components.
  
  ```

## Requirements

- iOS 17+
- Swift / SwiftUI only — no third-party dependencies .

## Extending 

- Replace `MockAuthenticationService` with a real implementation of
  `AuthenticationService` (Firebase, your own REST API, etc.) — no other
  file needs to change.
- Wire `showForgotPasswordSheet`, `showPrivacySheet`, and `showTermsSheet`
  in `LoginView` to real content; they currently open placeholder sheets.

  ## Designed and Developed by: Muhammad Zahid Khan iOS developer  
