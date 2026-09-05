//
//  LoginHeaderWaveShape.swift
//  LogInPage-MVVM
//
//  Created by Z.K   on 04/09/2026.
//

import SwiftUI

// MARK: - LoginHeaderWaveShape
/// Organic double-wave shape for the header, matching the reference image's
/// curved bottom edge. Built with relative control points so it scales
/// correctly across all iPhone sizes.
struct LoginHeaderWaveShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let w = rect.width
        let h = rect.height

        // Flat top and right side.
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: w, y: 0))
        path.addLine(to: CGPoint(x: w, y: h * 0.78))

        // Right dip down to mid trough.
        path.addCurve(
            to: CGPoint(x: w * 0.68, y: h * 0.92),
            control1: CGPoint(x: w * 0.90, y: h * 0.80),
            control2: CGPoint(x: w * 0.80, y: h * 0.92)
        )

        // Rise into middle crest (logo sits above).
        path.addCurve(
            to: CGPoint(x: w * 0.32, y: h * 0.92),
            control1: CGPoint(x: w * 0.56, y: h * 0.92),
            control2: CGPoint(x: w * 0.44, y: h * 0.92)
        )

        // Dip back down on the left side.
        path.addCurve(
            to: CGPoint(x: 0, y: h * 0.78),
            control1: CGPoint(x: w * 0.20, y: h * 0.92),
            control2: CGPoint(x: w * 0.10, y: h * 0.80)
        )

        path.closeSubpath()
        return path
    }
}
