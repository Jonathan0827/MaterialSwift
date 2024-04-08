//
//  Button.swift
//  MaterialSwift
//
//  Created by 임준협 on 4/7/24.
//

import Foundation
import SwiftUI

struct MaterialButton: ButtonStyle {
    let type: MaterialButtonType
    let icon: Image?
    let size: CGFloat?
    init (type: MaterialButtonType, icon: Image? = nil, size: CGFloat = 14) {
        self.type = type
        self.icon = icon
        self.size = size
    }
    func makeBody(configuration: Configuration) -> some View {
//        if type != .outlined && type != .text {
            
                HStack(spacing: 0) {
                    if icon != nil {
                        icon!
                            .resizable()
                            .frame(width: 18, height: 18)
                            .padding(.trailing, 8)
                    }
                    configuration.label
                        .font(.system(size: size!))
                    
                }
                .frame(height: 40)
                .padding(.leading, icon == nil ? buttonProperties(type).defaultPadding : buttonProperties(type).paddingIcon[0])
                .padding(.trailing, icon == nil ? buttonProperties(type).defaultPadding : buttonProperties(type).paddingIcon[1])
                .background {
                    ZStack {
                        if type == .elevated {
                            Capsule()
                                .fill(.black.opacity(0.2))
                                .padding(.bottom, -1)
                                .shadow(color: .black, radius: 1)
                        }
                        
                        Capsule()
                            .fill(
                                buttonProperties(type).container
                            )
                            .overlay {
                                if type == .outlined {
                                    Capsule()
                                        .stroke(
                                            buttonProperties(type).text,
                                            lineWidth: 1
                                        )
                                }
                            }
                        
                    }
                }
                .foregroundStyle(buttonProperties(type).text)
                .overlay{
                    if configuration.isPressed {
                        Capsule()
                            .fill(buttonProperties(type).text.opacity(0.1))
                    }
                }
            
//        } else {
//            configuration.label
//                .frame(height: 40)
//                .background {
//                    Capsule()
//                }
//        }
    }
}

enum MaterialButtonType: CaseIterable {
    case elevated
    case filled
    case filled_tonal
    case outlined
    case text
}
let MButtonTypeList: [MaterialButtonType] = [.elevated, .filled, .filled_tonal, .outlined, .text]
struct buttonOption {
    let container: Color
    let text: Color
    let defaultPadding: CGFloat
    let paddingIcon: [CGFloat]
}

func buttonProperties(_ button: MaterialButtonType) -> buttonOption {
    switch button {
    case .elevated:
        return buttonOption(container: .mSurfaceContainerLow, text: .mPrimary, defaultPadding: 24, paddingIcon: [16, 24])
    case .filled:
        return buttonOption(container: .mPrimary, text: .onPrimary, defaultPadding: 24, paddingIcon: [16, 24])
    case .filled_tonal:
        return buttonOption(container: .mSecondaryContainer, text: .onSecondaryContainer, defaultPadding: 24, paddingIcon: [16, 24])
    case .outlined:
        return buttonOption(container: .clear, text: .mPrimary, defaultPadding: 24, paddingIcon: [16, 24])
    case .text:
        return buttonOption(container: .clear, text: .mPrimary, defaultPadding: 12, paddingIcon: [12, 16])
    }
}

