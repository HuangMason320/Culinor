//
//  PreviewData.swift
//  APP
//
//  Created by Mason Huang on 2024/6/5.
//

import Foundation
import SwiftUI

var storagePreviewData = Storage(id: 1, name: "Meat", year: "2024", month: 6, date: 14, description: "GREAT", price: 23.00, imageURL: "0", calories: 12, protein: 12, carbs: 12, amount: 2)

var storageListPreviewData = [Storage](repeating: storagePreviewData, count: 10)
