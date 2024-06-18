//
//  RecentStorageList.swift
//  APP
//
//  Created by Mason Huang on 2024/6/7.
//

import SwiftUI

struct RecentStorageList: View {
    @EnvironmentObject var storageListVM: StorageListViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text("Recent Storage")
                    .bold()
                
                Spacer()
                
                NavigationLink {
                    StorageList()
                } label: {
                    HStack(spacing: 4) {
                        Text("See ALL")
                        Image(systemName: "chevron.right")
                    }
                    .foregroundColor(Color.text)
                }
            }
            .padding(.top)
            
            ForEach(Array(storageListVM.storage.prefix(5).enumerated()), id: \.element) { index, storage in
                StorageRow(storage: storage)
                
                Divider()
                    .opacity(index == 4 ? 0 : 1)
            }
        }
        .padding()
        .background(Color.systemBackground)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Color.primary.opacity(0.2), radius: 10, x: 0, y: 5)
    }
}

struct RecentStorageList_Preview: PreviewProvider {
    static let storageListVM: StorageListViewModel = {
        let storageListVM = StorageListViewModel()
        storageListVM.storage = storageListPreviewData
        return storageListVM
    }()
    
    static var previews: some View {
        RecentStorageList()
            .environmentObject(storageListVM)
    }
}
                                        
//#Preview {
//    RecentStorageList()
//}
