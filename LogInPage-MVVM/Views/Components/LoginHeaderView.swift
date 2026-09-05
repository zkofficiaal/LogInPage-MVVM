//
//  LoginHeaderView.swift
//  LogInPage-MVVM
//
//  Created by Z.K   on 04/09/2026.
//

import SwiftUI

// MARK: - LoginHeaderView
struct LoginHeaderView: View {
    var body: some View {
        ZStack {
            LoginHeaderWaveShape()
                .fill(AppTheme.accentGreen) // Header background
                .ignoresSafeArea(edges: .top)

            VStack(spacing: LoginSpacing.small) {
                //logoMark
                  //  .padding(.bottom, 2)

                VStack(spacing: 4) {
                    Text("Welcome to")
                        .font(.system(size: 18, weight: .medium)) // smaller size
                        .foregroundColor(AppTheme.onAccentPrimary)

                    Text("𝓓𝓮𝓿𝓣𝓮𝓬𝓱𝓩𝓪𝓱𝓲𝓭")
                        .font(.system(size: 27, weight: .bold))   // larger size
                        .foregroundColor(AppTheme.onAccentPrimary)
                }
                .multilineTextAlignment(.center)



                Text("Sign in to access your wallet and\nmanage your assets securely.")
                    .font(.system(size: 12, weight: .medium))
                    .multilineTextAlignment(.center)
                    .foregroundColor(AppTheme.onAccentSecondary)
                    .lineSpacing(2)
            }
            .padding(.top, 40)
        }
        .frame(height: 260)
    }

    // MARK: - LogoMark
    /// Minimal geometric logo mark rendered in vector form.
    private var logoMark: some View {
        Image(systemName: "diamond.fill")
            .resizable()
            .scaledToFit()
            .frame(width: 22, height: 22)
            .foregroundColor(.black)
    }
}

#Preview {
    LoginHeaderView()
        .background(AppTheme.background)
}
