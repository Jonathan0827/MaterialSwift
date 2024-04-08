//
//  IconButton.swift
//  MaterialSwift
//
//  Created by 임준협 on 4/7/24.
//

import Foundation
import SwiftUI
import UIKit

struct MaterialIconButton: View {
    let action: () -> Void
    let icon: String
    let type: MIconButtonType
    @State var isPressed = false
    init(action: @escaping () -> Void = EmptyFunction, icon: String, type: MIconButtonType) {
        self.action = action
        self.icon = icon
        self.type = type
    }
    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .resizable()
                .frame(width: 24, height: 24)
                .padding(8)
                .foregroundColor(iconButtonProperties(type).icon)
                .background(
                    Circle()
                        .fill(iconButtonProperties(type).container)
                        .overlay {
                            if type == .outlined {
                                Circle()
                                    .stroke(
                                        iconButtonProperties(type).icon,
                                        lineWidth: 1
                                    )
                            }
                        }
                )
        }
        .padding(4)
        .buttonStyle(IconButtonStyleForPress(buttonType: type))
    }
}
struct IconButtonStyleForPress: ButtonStyle {
    let buttonType: MIconButtonType
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .overlay {
                if configuration.isPressed {
                    Circle()
                        .fill(iconButtonProperties(buttonType).icon.opacity(0.1))
                }
            }
    }
}
enum MIconButtonType {
    case filled
    case filled_tonal
    case outlined
    case standard
}
let MIconButtonTypeList: [MIconButtonType] = [.filled, .filled_tonal, .outlined, .standard]
struct iconbuttonOption {
    let container: Color
    let icon: Color
}
func iconButtonProperties(_ button: MIconButtonType) -> iconbuttonOption {
    switch button {
        case .filled:
            return iconbuttonOption(container: .mPrimary, icon: .onPrimary)
        case .filled_tonal:
            return iconbuttonOption(container: .mSecondaryContainer, icon: .onSecondaryContainer)
        case .outlined:
            return iconbuttonOption(container: .clear, icon: .onSurfaceVariant)
        case .standard:
            return iconbuttonOption(container: .clear, icon: .onSurfaceVariant)
    }
}

func EmptyFunction() {}
