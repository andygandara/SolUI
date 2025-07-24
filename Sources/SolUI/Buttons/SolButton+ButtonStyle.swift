//
//  SolButton+ButtonStyle.swift
//  SolUI
//
//  Created by Andy Gandara on 7/23/25.
//

import SwiftUI

/// A style container for custom buttons that defines foreground and background colors.
public struct ButtonStyle: Equatable, Sendable {
    /// The color of the button's foreground content (e.g., text or icon).
    public let foregroundColor: Color
    
    /// The color of the button's background.
    public let backgroundColor: Color
    
    /// Private initializer to create a ButtonStyle instance with specified foreground and background colors.
    /// This is only accessible within this file to control style creation.
    public init(
        foregroundColor: Color,
        backgroundColor: Color
    ) {
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
    }
}

extension ButtonStyle {
    
    /// A primary button style.
    ///
    /// Intended for main call-to-action buttons.
    public static let primary = ButtonStyle(foregroundColor: Color(uiColor: .systemBackground), backgroundColor: Color.primary)
    
    /// A secondary button style.
    ///
    /// Intended for less prominent or secondary actions.
    public static let secondary = ButtonStyle(foregroundColor: .primary, backgroundColor: .gray.opacity(0.3))
    
    /// A destructive button style.
    ///
    /// Intended for actions that perform destructive or irreversible tasks.
    public static let destructive = ButtonStyle(foregroundColor: .white, backgroundColor: .red)
}
