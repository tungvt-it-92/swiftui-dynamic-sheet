//
//  ContentView.swift
//  SwiftUIDynamicSheet
//

import SwiftUI

struct ContentView: View {
    @State var isPresented: Bool = false
    @State var itemCount: Int = 0
    
    var body: some View {
        VStack {
            Button("Show 2 items in a sheet") {
                itemCount = 2
                isPresented.toggle()
            }
            .padding()
            .background(Color.gray.opacity(0.5))
            .cornerRadius(10)
            
            Button("Show 5 items in a sheet") {
                itemCount = 5
                isPresented.toggle()
            }
            .padding()
            .background(Color.gray.opacity(0.5))
            .cornerRadius(10)
            
            Button("Show 20 items in a sheet") {
                itemCount = 20
                isPresented.toggle()
            }
            .padding()
            .background(Color.gray.opacity(0.5))
            .cornerRadius(10)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .background(
            Color.green.opacity(0.3)
        )
        .dynamicHeightSheet(isPresented: $isPresented) {
            SheetContent(itemCount: itemCount)
                .presentationDragIndicator(.visible)
        }
    }
}

struct SheetContent: View {
    @State var itemCount: Int
    
    var body: some View {
        VStack {
            ForEach(0..<itemCount, id: \.self) { index in
                Text("Item: \(index + 1)")
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
}

#Preview {
    ContentView()
}
