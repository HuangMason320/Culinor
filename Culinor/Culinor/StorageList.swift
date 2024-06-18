//
//  StorageList.swift
//  APP
//
//  Created by Mason Huang on 2024/6/7.
//

import SwiftUI

struct StorageList: View {
    @EnvironmentObject var storageListVM: StorageListViewModel
    
    var body: some View {
        VStack {
            List {
                ForEach(Array(storageListVM.groupStorageByMonth()), id: \.key) { month, storage in
                    Section {
                        ForEach(storage) { storage in
                            StorageRow(storage: storage)
                        }
                    } header: {
                        Text(month)
                    }
                    .listSectionSeparator(.hidden)
                }
            }
            .listStyle(.plain)
        }
        .navigationTitle("Storage")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct StorageList_Previews: PreviewProvider {
    static let storageListVM: StorageListViewModel = {
        let storageListVM = StorageListViewModel()
        storageListVM.storage = storageListPreviewData
        return storageListVM
    }()
    
    static var previews: some View {
        NavigationView {
            StorageList()
                .environmentObject(storageListVM)
        }
    }
}

//
//#Preview {
//    NavigationView {
//        StorageList()
//    }
//}
