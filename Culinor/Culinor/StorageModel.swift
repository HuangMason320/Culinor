//
//  StorageModel.swift
//  APP
//
//  Created by Mason Huang on 2024/5/31.
//

import Foundation

struct Storage: Identifiable, Decodable, Hashable {
    let id: Int
    let name: String
    let year: String
    let month: Int
    let date: Int
    let description: String
    let price: Double
    let imageURL: String
    let calories: Int
    let protein: Int
    let carbs: Int
    let amount: Int
    
    var dateParsed: Date {
        date.description.dateParsed()
    }
}


