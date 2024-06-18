//
//  StorageRow.swift
//  APP
//
//  Created by Mason Huang on 2024/5/31.
//

import SwiftUI

struct StorageRow: View {
    var storage: Storage
    var body: some View {
        HStack(spacing: 20){
            Image("\(storage.id)")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80, height: 60)
                .clipShape(RoundedRectangle(cornerRadius: 20))
//                .overlay(
//                    RoundedRectangle(cornerRadius: 10)
//                        .stroke(Color.white, lineWidth: 0)
//                )
//                .shadow(radius: 5)
            
            VStack(alignment: .leading, spacing: 6) {
                Text(storage.name)
                    .font(.subheadline)
                    .bold()
                    .lineLimit(1)
                
                Text(storage.description)
                    .font(.footnote)
                    .opacity(0.7)
                    .lineLimit(1)
                
                Text(storage.dateParsed, format: .dateTime.year().month().day())
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Text("\(storage.amount)")
                .bold()
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
        }
        .padding([.top, .bottom], 8)
    }
}

#Preview {
    StorageRow(storage: storagePreviewData)
}
