//
//  SegmentedButtons.swift
//  MaterialSwift
//
//  Created by 임준협 on 4/7/24.
//

import Foundation
import SwiftUI
struct SegmentedButtons: View {
    @State var maximumSelection: Int
    @State var selectionOrder = [Int]()
    @State var sizes = [CGSize]()
    @State var widths: CGFloat = .zero
    let buttons: [segmentedButton]
    init(maximumSelection: Int = 1, selectionOrder: [Int] = [Int](), sizes: [CGSize] = [CGSize](), widths: CGFloat = .zero, buttons: [segmentedButton]) {
        self.maximumSelection = maximumSelection
        self.selectionOrder = selectionOrder
        self.sizes = sizes
        self.widths = widths
        self.buttons = buttons
    }
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<buttons.count) { index in
                Button(action: {
                    if selectionOrder.contains(index) {
                        withAnimation(.easeInOut(duration: 0.1)) {
                            selectionOrder.removeAll { $0 == index }
                        }
                    } else {
                        if selectionOrder.count < maximumSelection {
                            withAnimation(.easeInOut(duration: 0.1)) {
                                selectionOrder.append(index)
                            }
                        } else {
                            withAnimation(.easeInOut(duration: 0.1)) {
                                selectionOrder.removeFirst()
                                selectionOrder.append(index)
                            }
                        }
                    }
                    buttons[index].action()
                }, label: {
                    HStack(spacing: 8) {
                        if buttons[index].icon != "" {
                            Image(systemName: selectionOrder.contains(index) ? "checkmark" : buttons[index].icon)
                                .resizable()
                                .frame(width: 18, height: 18)
                                .padding(.bottom, 4)
                                .foregroundColor(selectionOrder.contains(index) ? .mPrimary : .mOutline)
                        }
                        Text(buttons[index].text)
                            .font(.system(size: 14))
                            .foregroundColor(selectionOrder.contains(index) ? .onSecondaryContainer : .onSurface)
                    }
                    .padding(.horizontal, 12)
                    .frame(minWidth: [widths, 48].max())
                    .background {
                        switch index {
                        case 0:
                            UnevenRoundedRectangle(cornerRadii: .init(topLeading: 100, bottomLeading: 100, bottomTrailing: 0, topTrailing: 0))
                                .stroke(.mOutline, lineWidth: 1)
                                .frame(height: 40)
                                .background(
                                    UnevenRoundedRectangle(cornerRadii: .init(topLeading: 100, bottomLeading: 100, bottomTrailing: 0, topTrailing: 0)).fill(selectionOrder.contains(index) ? .mSecondaryContainer : .clear)
                                )
                        case buttons.count - 1:
                            UnevenRoundedRectangle(cornerRadii: .init(topLeading: 0, bottomLeading: 0, bottomTrailing: 100, topTrailing: 100))
                                .stroke(.mOutline, lineWidth: 1)
//                                .frame(minWidth: [widths, 48].max())
                                .frame(height: 40)
                                .background(
                                    UnevenRoundedRectangle(cornerRadii: .init(topLeading: 0, bottomLeading: 0, bottomTrailing: 100, topTrailing: 100)).fill(selectionOrder.contains(index) ? .mSecondaryContainer : .clear)
                                )
                        default:
                            Rectangle()
                                .stroke(.mOutline, lineWidth: 1)
//                                .frame(minWidth: [widths, 48].max())
                                .frame(height: 40)
                                .background(
                                    Rectangle().fill(selectionOrder.contains(index) ? .mSecondaryContainer : .clear)
                                )
                        }
                    }
                })
                
                .padding(.vertical, 4)
                .saveSizeToArray(in: $sizes)
            }
        }
        .frame(minWidth: [widths, 48].max()! * CGFloat(buttons.count))
        .onChange(of: sizes) { nV in
            var tempSize = [CGFloat]()
            nV.forEach { size in
                tempSize.append(size.width)
            }
            widths = tempSize.max() ?? .zero
        }
    }
}

struct segmentedButton {
    let text: String
    let icon: String
    let action: () -> Void
    let showIconOnSelect: Bool
    init(text: String, icon: String = "", action: @escaping () -> Void = EmptyFunction, showIconOnSelect: Bool = false) {
        self.text = text
        self.icon = icon
        self.action = action
        self.showIconOnSelect = showIconOnSelect
    }
}

struct SizeCalculator: ViewModifier {
    
    @Binding var size: [CGSize]
    
    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { proxy in
                    Color.clear // we just want the reader to get triggered, so let's use an empty color
                        .onAppear {
                            size.append(proxy.size)
                        }
                }
            )
    }
}

extension View {
    func saveSizeToArray(in size: Binding<Array<CGSize>>) -> some View {
        modifier(SizeCalculator(size: size))
    }
}
