//
//  SolButton+ButtonSize.swift
//  SolUI
//
//  Created by Andy Gandara on 8/8/25.
//

import SwiftUI

/// A size config container for custom buttons.
public struct ButtonSize: Equatable, Sendable {
    /// The font of the button's text label.
    public let font: Font
    
    /// The horizontal padding (in points) applied to both sides of the button's content.
    /// Adjusts the button's width by increasing or decreasing space to the left and right of the text or icon.
    public let horizontalPadding: CGFloat
    
    /// The minimum height of the button.
    /// Used to ensure the button has an accessible touch target and consistent sizing.
    public let minHeight: CGFloat
    
    /// Private initializer to create a ButtonSize instance with specified font.
    /// This is only accessible within this file to control size creation.
    public init(font: Font, horizontalPadding: CGFloat, minHeight: CGFloat) {
        self.font = font
        self.horizontalPadding = horizontalPadding
        self.minHeight = minHeight
    }
}

extension ButtonSize {
    /// A mini button style.
    public static let mini = ButtonSize(font: .caption, horizontalPadding: 2, minHeight: 12)
    
    /// A compact button style.
    public static let compact = ButtonSize(font: .subheadline, horizontalPadding: 4, minHeight: 24)
    
    /// A primary button style.
    public static let standard = ButtonSize(font: .body, horizontalPadding: 8, minHeight: 36)
}

