//
//  SolTextField+Modifiers.swift
//  SolUI
//
//  Created by Andy Gandara on 7/25/25.
//

import SwiftUI

extension EnvironmentValues {
    @Entry var solTextFieldFont: Font?
    @Entry var solTextFieldTitleFont: Font?
}

extension View {
    public func solTextFieldFont(_ font: Font) -> some View {
        self.environment(\.solTextFieldFont, font)
    }
    
    public func solTextFieldTitleFont(_ font: Font) -> some View {
        self.environment(\.solTextFieldTitleFont, font)
    }
}
