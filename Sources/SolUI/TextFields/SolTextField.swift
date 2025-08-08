//
//  SolTextField.swift
//  SolUI
//
//  Created by Andy Gandara on 7/25/25.
//

import SwiftUI

public enum SolTextFieldValidationResult: Equatable, Hashable, Sendable {
    case ok
    case warning(String)
    case error(String)
}

@available(iOS 17.0, *)
public struct SolTextField: View {
    @Environment(\.solTextFieldFont) private var font: Font?
    @Environment(\.solTextFieldTitleFont) private var titleFont: Font?
    
    let titleKey: LocalizedStringKey
    let text: Binding<String>
    let placeholder: String?
    let axis: Axis
    let validate: ((String) -> SolTextFieldValidationResult)?
    @State private var validationResult: SolTextFieldValidationResult = .ok
    @State private var showErrorMessage = false
    
    init(
        _ titleKey: LocalizedStringKey,
        text: Binding<String>,
        placeholder: String? = nil,
        axis: Axis = .horizontal,
        validate: ((String) -> SolTextFieldValidationResult)? = nil
    ) {
        self.titleKey = titleKey
        self.text = text
        self.placeholder = placeholder
        self.axis = axis
        self.validate = validate
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .firstTextBaseline, spacing: 4) {
                Text(titleKey)
                    .font(titleFont ?? .subheadline)
                    .foregroundStyle(.secondary)
                validationIcon
            }
            TextField(placeholder ?? "", text: text, axis: axis)
                .font(font ?? .body)
        }
        .onChange(of: text.wrappedValue) { _, new in
            if let validate {
                validationResult = validate(new)
            }
        }
        .animation(.interactiveSpring, value: validationResult)
    }
    
    @ViewBuilder
    private var validationIcon: some View {
        if validationResult != .ok {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.subheadline)
                .foregroundStyle(validationResult.iconColor)
                .onTapGesture {
                    showErrorMessage = true
                }
                .popover(isPresented: $showErrorMessage) {
                    validationPopover
                }
        }
    }
    
    @ViewBuilder
    private var validationPopover: some View {
        HStack(alignment: .firstTextBaseline, spacing: 4) {
            Text(validationResult.message)
        }
        .padding()
        .presentationCompactAdaptation(.popover)
    }
}

private extension SolTextFieldValidationResult {
    var iconColor: Color {
        switch self {
        case .ok:       .clear
        case .warning:  .yellow
        case .error:    .red
        }
    }
    
    var message: String {
        switch self {
        case .warning(let message), .error(let message):
            return message
        case .ok:
            return ""
        }
    }
}

@available(iOS 17.0, *)
#Preview {
    @Previewable @State var firstName = "Andy"
    @Previewable @State var lastName = "Gandara"
    
    @Previewable @State var street1 = "525 E Willetta St"
    @Previewable @State var street2 = "#9"
    @Previewable @State var city = "Phoenix"
    @Previewable @State var state = "AZ"
    
    Form {
        Section {
            SolTextField("First name", text: $firstName, placeholder: "Placeholder") { text in
                switch text {
                case "Andyy":
                    return .warning("Warninig message")
                case "Andyyy":
                    return .error("Error message")
                default:
                    return .ok
                }
            }
            SolTextField("Last name", text: $lastName, axis: .vertical)
        }
        
        Section {
            SolTextField("Street", text: $street1, placeholder: "Placeholder")
            SolTextField("Street", text: $street2)
            
            HStack {
                SolTextField("City", text: $city)
                SolTextField("State", text: $state)
            }
        }
    }
}
