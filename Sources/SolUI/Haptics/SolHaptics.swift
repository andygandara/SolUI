//
//  SolHaptics.swift
//  SolUI
//
//  Created by Andy Gandara on 7/23/25.
//

import UIKit

/// A utility type that provides a simple interface for triggering haptic feedback on supported Apple devices.
/// This enum offers methods for generating impact and notification feedback, abstracting UIKit's feedback generators.
public enum SolHaptics {
    /// Triggers an impact feedback of the specified style using `UIImpactFeedbackGenerator`.
    ///
    /// Use this method to simulate physical impacts or collisions with varying intensity.
    /// This feedback is typically used to indicate a physical touch or impact in the UI.
    ///
    /// - Parameter feedbackStyle: The style of the impact feedback.
    ///   Possible values include:
    ///   - `.light`: A lighter impact, suitable for subtle feedback.
    ///   - `.medium`: A moderate impact, commonly used for standard taps.
    ///   - `.heavy`: A stronger impact, for more pronounced feedback.
    ///   - `.soft`: A softer impact feel (available on supported devices).
    ///   - `.rigid`: A sharper impact feel (available on supported devices).
    ///
    /// This method must be called on the main thread.
    @MainActor
    public static func impact(_ feedbackStyle: UIImpactFeedbackGenerator.FeedbackStyle) {
        UIImpactFeedbackGenerator(style: feedbackStyle).impactOccurred()
    }
    
    /// Triggers a notification feedback of the specified type using `UINotificationFeedbackGenerator`.
    ///
    /// Use this method to indicate the result of a task or operation, signaling success, warning, or error states.
    ///
    /// - Parameter feedbackType: The type of notification feedback.
    ///   Possible values include:
    ///   - `.success`: Indicates a successful or positive outcome.
    ///   - `.warning`: Indicates a warning or cautionary state.
    ///   - `.error`: Indicates an error or failure condition.
    ///
    /// This method must be called on the main thread.
    @MainActor
    public static func notify(_ feedbackType: UINotificationFeedbackGenerator.FeedbackType) {
        UINotificationFeedbackGenerator().notificationOccurred(feedbackType)
    }
}
