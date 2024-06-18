//
//  Extension.swift
//  APP
//
//  Created by Mason Huang on 2024/5/31.
//

import Foundation
import SwiftUI

extension Color {
    static let Background = Color("Background")
    static let Icon = Color("Icon")
    static let Text = Color("Text")
    static let systemBackground = Color(uiColor: .systemBackground)
}

extension DateFormatter {
    static let allNemericUSA: DateFormatter = {
        print("Initializing DateFormatter")
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        
        return formatter
    }()
}

extension String {
    func dateParsed() -> Date {
        guard let parsedDate = DateFormatter.allNemericUSA.date(from: self) else {return Date()}
        
        return parsedDate
    }
}

//extension Date: Strideable {
//    func formatted() -> String {
//        return self.formatted(.dateTime.year().month().day())
//    }
//}
