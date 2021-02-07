//
//  FruitsController.swift
//  SearchBarSwiftUI
//
//  Created by Sören Kirchner on 30.01.21.
//

import Foundation

struct Fruit: Identifiable {
    let id = UUID()
    let name: String
}

class FruitsController: ObservableObject {
    let fruits = [Fruit(name: "Jackfruit"), Fruit(name: "Apples"), Fruit(name: "Banana"), Fruit(name: "Lemon"), Fruit(name: "Orange"), Fruit(name: "Pineapple"), Fruit(name: "Passion Fruit"), Fruit(name: "Plum"), Fruit(name: "Strawberry"), Fruit(name: "Pear"), Fruit(name: "Cherry"), Fruit(name: "Physalis"), Fruit(name: "Gooseberry"), Fruit(name: "Currant"), Fruit(name: "Grape"), Fruit(name: "Coconut"), Fruit(name: "Peach"), Fruit(name: "Mango"), Fruit(name: "Melon"), Fruit(name: "Blackberry"), Fruit(name: "Blueberry"), Fruit(name: "Grapefruit"), Fruit(name: "Lime")]
    @Published var publishedFruits = [Fruit]()
    
    init() {
        publishedFruits = fruits
    }
    
    public func search(for key: String) {
        publishedFruits = fruits.filter {key.isEmpty ? true : $0.name.lowercased().contains(key.lowercased())}
    }
}

