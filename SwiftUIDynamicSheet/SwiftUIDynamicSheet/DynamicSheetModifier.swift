//
//  DynamicSheetModifier.swift
//  SwiftUIDynamicSheet
//

import SwiftUI

struct DynamicHeightSheetModifier<SheetContent: View>: ViewModifier {
    @Binding var isPresented: Bool
    let sheetContent: SheetContent
    @State private var sheetContentHeight: CGFloat = 0

    init(
        isPresented: Binding<Bool>,
        sheetContent: @escaping () -> SheetContent
    ) {
        _isPresented = isPresented
        self.sheetContent = sheetContent()
    }

    func body(content: Content) -> some View {
        content
            .sheet(isPresented: $isPresented) {
                ScrollView {
                    sheetContent
                        .frame(maxWidth: .infinity)
                        .background(
                            GeometryReader { proxy in
                                Color.clear
                                    .task {
                                        updateSheetHeight(proxy.size.height)
                                    }
                                    .onChange(of: proxy.size.height) {
                                        newHeight in
                                        updateSheetHeight(newHeight)
                                    }
                            }
                        )
                }
                .presentationDetents([.height(sheetContentHeight)])
            }
    }

    private func updateSheetHeight(_ newHeight: CGFloat) {
        if sheetContentHeight != newHeight {
            sheetContentHeight = newHeight
        }
    }
}

extension View {
    public func dynamicHeightSheet<SheetContent: View>(
        isPresented: Binding<Bool>,
        @ViewBuilder content: @escaping () -> SheetContent
    ) -> some View {
        modifier(
            DynamicHeightSheetModifier(
                isPresented: isPresented,
                sheetContent: content
            )
        )
    }
}
