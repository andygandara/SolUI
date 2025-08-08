//
//  SolButton+Modifiers.swift
//  SolUI
//
//  Created by Andy Gandara on 7/23/25.
//

import SwiftUI

extension EnvironmentValues {
    @Entry var solButtonStyle: ButtonStyle = .primary
    @Entry var solButtonButtonShape: ButtonBorderShape = .capsule
    @Entry var solButtonSize: ButtonSize = .standard
    @Entry var solButtonHugsContent: Bool = false
    @Entry var solButtonIconLeading: Bool = false
    @Entry var solHaptics: UIImpactFeedbackGenerator.FeedbackStyle? = .light
}

extension View {
    /// Sets the SolButton style for this view hierarchy.
    ///
    /// - Parameter style: The `ButtonStyle` to use. Defaults to `.primary` if unset.
    /// - Returns: A view that applies the given style to SolButtons within.
    public func solButtonStyle(_ style: ButtonStyle) -> some View {
        self.environment(\.solButtonStyle, style)
    }
    
    /// Sets the border shape of SolButtons in this view hierarchy.
    ///
    /// - Parameter shape: The `ButtonBorderShape` to use. Defaults to `.capsule` if unset.
    /// - Returns: A view that applies the given border shape.
    public func solButtonBorderShape(_ shape: ButtonBorderShape) -> some View {
        self.environment(\.solButtonButtonShape, shape)
    }
    
    /// Sets the size of SolButtons in this view hierarchy.
    ///
    /// - Parameter size: The `ButtonSize` to use. Defaults to `.standard` if unset.
    /// - Returns: A view that applies the given size to SolButtons within.
    public func solButtonSize(_ size: ButtonSize) -> some View {
        self.environment(\.solButtonSize, size)
    }
    
    /// Configures whether SolButtons in this view hierarchy should tightly hug their content.
    ///
    /// - Parameter hugsContent: If true, the button resizes to fit its content. Defaults to false.
    /// - Returns: A view that applies this behavior to contained SolButtons.
    public func solButtonHugsContent(_ hugsContent: Bool = false) -> some View {
        self.environment(\.solButtonHugsContent, hugsContent)
    }
    
    /// Sets whether SolButtons in this view hierarchy should display their icon on the leading edge.
    ///
    /// - Parameter iconLeading: If true, places the icon before the label. Defaults to false.
    /// - Returns: A view that applies this layout preference.
    public func solButtonIconLeading(_ iconLeading: Bool = false) -> some View {
        self.environment(\.solButtonIconLeading, iconLeading)
    }
    
    /// Sets the haptic feedback style for SolButtons within this view hierarchy.
    ///
    /// - Parameter style: The `UIImpactFeedbackGenerator.FeedbackStyle` to use for haptics. Defaults to `.light`. Pass nil to disable haptic feedback.
    /// - Returns: A view that applies this haptic feedback behavior.
    public func solHaptics(_ style: UIImpactFeedbackGenerator.FeedbackStyle? = .light) -> some View {
        self.environment(\.solHaptics, style)
    }
}

