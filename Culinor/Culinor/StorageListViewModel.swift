//
//  StorageListViewModel.swift
//  APP
//
//  Created by Mason Huang on 2024/6/6.
//

import Foundation
import Combine

typealias StorageGroup = Dictionary<String, [Storage]>
typealias StoragePrefixSum = [(String, Double)]

final class StorageListViewModel: ObservableObject {
    @Published var storage: [Storage] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        getStorage()
    }
    
    func getStorage() {
        guard let url = Bundle.main.url(forResource: "Storage", withExtension: "json") else {
            print("Invalid URL")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decodedStorage = try JSONDecoder().decode([Storage].self, from: data)
            DispatchQueue.main.async {
                self.storage = decodedStorage
            }
        } catch {
            print("Error fetching storage:", error.localizedDescription)
        }
    }
    
//    func groupStorageByMonth() -> StorageGroup {
//        guard !storage.isEmpty else { return [:]}
//        
//        let storageGroup = StorageGroup(grouping: storage) { "\($0.month)" }
//        
//        return storageGroup
//    }
    func groupStorageByMonth() -> [(key: String, value: [Storage])] {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM yyyy"

            let grouped = Dictionary(grouping: storage) { item -> String in
                let components = DateComponents(year: Int(item.year), month: item.month)
                let calendar = Calendar.current
                if let date = calendar.date(from: components) {
                    return dateFormatter.string(from: date)
                } else {
                    return "Unknown"
                }
            }

            return grouped.mapValues { $0.sorted { $0.year + String(format: "%02d", $0.month) < $1.year + String(format: "%02d", $1.month) } }
                .sorted { keyValue1, keyValue2 in
                    let date1 = dateFormatter.date(from: keyValue1.key) ?? Date()
                    let date2 = dateFormatter.date(from: keyValue2.key) ?? Date()
                    return date1 < date2
                }
        }
    
//    func accumulateStorage() -> StoragePrefixSum {
//        print ("accumulateStorage")
//        guard !storage.isEmpty else { return [] }
//        
//        let today = "06/07/2024".dateParsed()
//        let dateInterval = Calendar.current.dateInterval(of: .month, for: today)
//        print("dateInterval", dateInterval)
//        
//        var sum: Double = .zero
//        var accumulativeSum = StoragePrefixSum()
//        
//        for date in stride(from: dateInterval.start, to: today, by: 60 * 60 * 24) {
//            let dailyStorage = storage.filter( $0.dataParsed == date && )
//        }
//    }
}
