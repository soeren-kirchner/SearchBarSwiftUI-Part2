//
//  ContentView.swift
//  SearchBarSwiftUI
//
//  Created by Sören Kirchner on 30.01.21.
//

import SwiftUI

struct FruitsView: View {
    @ObservedObject var  fruitsController = FruitsController()
    @State var searchFieldValue = ""
    
    var body: some View {
        ScrollView {
            ScrollViewReader { proxy in
                LazyVStack(alignment: .leading, spacing: 20) {
                    SearchBar(text: $searchFieldValue)
                        .onChange(of: searchFieldValue) { value in
                            fruitsController.search(for: value)
                        }
                    ForEach (fruitsController.publishedFruits) { fruit in
                        Text(fruit.name)
                    }
                }
                .onAppear {
                    proxy.scrollTo(self.fruitsController.publishedFruits.first!.id)
                }
            }
        }
        .padding()
    }
}

struct SearchBar: View {
    @Binding var text: String
    @State var showCancelButton = false
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Search", text: $text)
                    .onTapGesture {
                        withAnimation {
                            showCancelButton = true
                        }
                    }
            }
            .padding(5)
            .background(Color(.systemFill))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(.systemFill), lineWidth: 1)
            )
            if showCancelButton {
                Button("cancel", action: {
                    hideKeyboard()
                    text = ""
                    withAnimation {
                        showCancelButton = false
                    }
                })
                .transition(.move(edge: .trailing))
            }
        }
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct ContentView: View {
    var body: some View {
        FruitsView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
