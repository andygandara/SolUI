//
//  SolButton.swift
//  SolUI
//
//  Created by Andy Gandara on 7/23/25.
//

import SwiftUI

/// A customizable, environment-aware button for SolUI that supports both synchronous and asynchronous actions.
///
/// SolButton can be configured with a title, optional system image, and provides automatic handling for loading states when used with async actions. It leverages environment values for style, shape, content hugging, icon placement, and optional haptic feedback.
///
/// Example usage:
///
/// ```swift
/// SolButton("Save", systemImage: "tray.and.arrow.down", action: {
///     // Perform save
/// })
/// .solButtonStyle(.primary)
///
/// SolButton("Load Data", systemImage: "arrow.down.circle", action: {
///     await viewModel.loadData()
/// })
/// .solButtonStyle(.secondary)
///
/// // Customization via environment
/// SolButton("Delete", systemImage: "trash", action: { /* ... */ })
///     .solButtonStyle(.destructive)
///     .solButtonHugsContent(true)
///     .solButtonIconLeading(true)
/// ```
///
/// - Note: Haptic feedback is triggered based on the environment's `solHaptics` value.
public struct SolButton: View {
    @Environment(\.solButtonStyle) private var buttonStyle: ButtonStyle
    @Environment(\.solButtonButtonShape) private var buttonShape: ButtonBorderShape
    @Environment(\.solButtonHugsContent) private var hugsContent: Bool
    @Environment(\.solButtonIconLeading) private var iconLeading: Bool
    @Environment(\.solHaptics) private var hapticsStyle: UIImpactFeedbackGenerator.FeedbackStyle?
    
    private let titleKey: LocalizedStringKey?
    private let systemImage: String?
    private let action: (() -> Void)?
    private let asyncAction: (() async -> Void)?
    @State private var isLoading = false
    
    /// Creates a SolButton with a title, optional system image, and synchronous action.
    /// - Parameters:
    ///   - titleKey: The button's localized title.
    ///   - systemImage: The optional SF Symbol image name to display.
    ///   - action: The synchronous action to perform on tap.
    public init(_ titleKey: LocalizedStringKey, systemImage: String? = nil, action: @escaping () -> Void) {
        self.titleKey = titleKey
        self.systemImage = systemImage
        self.action = action
        self.asyncAction = nil
    }
    
    /// Creates a SolButton with an optional system image (no title) and synchronous action.
    /// - Parameters:
    ///   - systemImage: The optional SF Symbol image name to display.
    ///   - action: The synchronous action to perform on tap.
    public init(systemImage: String? = nil, action: @escaping () -> Void) {
        self.titleKey = nil
        self.systemImage = systemImage
        self.action = action
        self.asyncAction = nil
    }
    
    /// Creates a SolButton with a title, optional system image, and asynchronous action.
    /// - Parameters:
    ///   - titleKey: The button's localized title.
    ///   - systemImage: The optional SF Symbol image name to display.
    ///   - action: The async action to perform on tap. While the async action is running, a loading indicator is shown and the button is disabled.
    public init(_ titleKey: LocalizedStringKey, systemImage: String? = nil, action: @escaping () async -> Void) {
        self.titleKey = titleKey
        self.systemImage = systemImage
        self.action = nil
        self.asyncAction = action
    }
    
    /// Creates a SolButton with an optional system image (no title) and asynchronous action.
    /// - Parameters:
    ///   - systemImage: The optional SF Symbol image name to display.
    ///   - action: The async action to perform on tap. While the async action is running, a loading indicator is shown and the button is disabled.
    public init(systemImage: String? = nil, action: @escaping () async -> Void) {
        self.titleKey = nil
        self.systemImage = systemImage
        self.action = nil
        self.asyncAction = action
    }
    
    public var body: some View {
        Button {
            performAction()
        } label: {
            buttonContent
        }
        .buttonBorderShape(buttonShape)
        .foregroundColor(buttonStyle.foregroundColor)
        .tint(buttonStyle.backgroundColor)
        .buttonStyle(.borderedProminent)
    }
    
    @ViewBuilder
    private var buttonContent: some View {
        HStack(spacing: 8) {
            labelContent
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 6)
        .frame(
            minWidth: 0,
            maxWidth: hugsContent ? nil : .infinity
        )
        .frame(minHeight: 36)
        .overlay { progressView }
    }
    
    @ViewBuilder
    private var labelContent: some View {
        Group {
            if iconLeading {
                if let systemImage {
                    Image(systemName: systemImage)
                }
                if let titleKey {
                    Text(titleKey)
                        .lineLimit(1)
                }
            } else {
                if let titleKey {
                    Text(titleKey)
                        .lineLimit(1)
                }
                if let systemImage {
                    Image(systemName: systemImage)
                }
            }
        }
        .font(.body)
        .fontWeight(.medium)
        .hidden(isLoading)
    }
    
    @ViewBuilder
    private var progressView: some View {
        if isLoading {
            ProgressView()
                .tint(buttonStyle.foregroundColor)
        }
    }
    
    private func performAction() {
        if let hapticsStyle {
            Haptics.impact(hapticsStyle)
        }
        
        if let action {
            action()
        } else if let asyncAction {
            guard !isLoading else { return }
            isLoading = true
            Task {
                defer { isLoading = false }
                await asyncAction()
            }
        }
    }
}

#Preview {
    @Previewable @State var hugsContent = false
    @Previewable @State var hasIcon = false
    @Previewable @State var iconLeading = false
    
    VStack {
        VStack {
            Toggle("Hugs Content", isOn: $hugsContent)
            Toggle("Has Icon", isOn: $hasIcon)
            if hasIcon {
                Toggle("Leading Icon", isOn: $iconLeading)
            }
        }
        .padding(.bottom, 40)
        
        Group {
            SolButton("Primary", systemImage: hasIcon ? "person" : nil, action: {})
                .solButtonStyle(.primary)
            
            SolButton("Secondary", systemImage: hasIcon ? "house" : nil, action: {})
                .solButtonStyle(.secondary)
            
            SolButton("Destructive", systemImage: hasIcon ? "trash" : nil, action: {})
                .solButtonStyle(.destructive)
            
            SolButton("Async Button", systemImage: hasIcon ? "person" : nil, action: {
                try? await Task.sleep(for: .seconds(3))
            })
            .solButtonStyle(.secondary)
        }
        .solButtonHugsContent(hugsContent)
        .solButtonIconLeading(iconLeading)
        .solButtonBorderShape(.capsule)
    }
    .animation(.bouncy, value: hugsContent)
    .animation(.bouncy, value: hasIcon)
    .animation(.bouncy, value: iconLeading)
    .padding(20)
}
