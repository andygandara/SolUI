//
//  View+Extensions.swift
//  SolUI
//
//  Created by Andy Gandara on 7/23/25.
//

import SwiftUI

extension View {
    @ViewBuilder
    func hidden(_ shouldHide: Bool) -> some View {
        if shouldHide {
            self.hidden()
        } else {
            self
        }
    }
}
