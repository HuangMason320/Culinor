//
//  AccountView.swift
//  APP
//
//  Created by Mason Huang on 2024/5/31.
//

import SwiftUI

struct AccountView: View {
    @Environment(\.presentationMode) var presentationMode
        
    var body: some View {
        NavigationView {
            List {
                Section {
                    HStack {
                        Image("user_profile") // 替換為你自己的頭貼圖片名稱
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())
                        VStack(alignment: .leading) {
                            Text("Tzu-yu Chou")
                                .font(.headline)
                            Text("tycyyds@kneron.us")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
                
                Section(header: Text("帳號設置")) {
                    NavigationLink(destination: UserProfileView()) {
                        Text("個人資料")
                    }
                    NavigationLink(destination: AddressManagementView()) {
                        Text("地址管理")
                    }
                    NavigationLink(destination: PaymentMethodsView()) {
                        Text("支付方式")
                    }
                }
                
                Section(header: Text("我的訂單")) {
                    NavigationLink(destination: PurchaseHistoryView()) {
                        Text("購買記錄")
                    }
                    NavigationLink(destination: PendingShipmentView()) {
                        Text("待發貨")
                    }
                    NavigationLink(destination: PendingReceiptView()) {
                        Text("待收貨")
                    }
                }
                
                Section(header: Text("我的收藏")) {
                    NavigationLink(destination: FavoriteRecipesView()) {
                        Text("收藏食譜")
                    }
                    NavigationLink(destination: FavoriteProductsView()) {
                        Text("收藏商品")
                    }
                }
                
                Section(header: Text("更多")) {
                    NavigationLink(destination: RedeemGiftCardView()) {
                        Text("兌換禮品卡或代碼")
                            .foregroundColor(.blue)
                    }
                    NavigationLink(destination: PersonalizedRecommendationsView()) {
                        Text("個人化推薦")
                    }
                    NavigationLink(destination: AppSettingsView()) {
                        Text("應用設置")
                    }
                    NavigationLink(destination: HelpSupportView()) {
                        Text("幫助與支持")
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("帳號", displayMode: .inline)
            .navigationBarItems(trailing: Button("完成") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

// 個人資料視圖
struct UserProfileView: View {
    var body: some View {
        Form {
            Section(header: Text("基本信息")) {
                TextField("姓名", text: .constant("Tzu-yu Chou"))
                TextField("電子郵件", text: .constant("tycyyds@kneron.us"))
            }
            Section(header: Text("安全")) {
                SecureField("密碼", text: .constant("password"))
            }
        }
        .navigationBarTitle("個人資料", displayMode: .inline)
    }
}

// 地址管理視圖
struct AddressManagementView: View {
    var body: some View {
        List {
            ForEach(0..<3) { index in
                Text("地址 \(index + 1)")
            }
        }
        .navigationBarTitle("地址管理", displayMode: .inline)
    }
}

// 支付方式視圖
struct PaymentMethodsView: View {
    var body: some View {
        List {
            ForEach(0..<2) { index in
                Text("信用卡 \(index + 1)")
            }
        }
        .navigationBarTitle("支付方式", displayMode: .inline)
    }
}

// 購買記錄視圖
struct PurchaseHistoryView: View {
    var body: some View {
        List {
            ForEach(0..<5) { index in
                Text("訂單 \(index + 1)")
            }
        }
        .navigationBarTitle("購買記錄", displayMode: .inline)
    }
}

// 待發貨視圖
struct PendingShipmentView: View {
    var body: some View {
        List {
            ForEach(0..<2) { index in
                Text("待發貨訂單 \(index + 1)")
            }
        }
        .navigationBarTitle("待發貨", displayMode: .inline)
    }
}

// 待收貨視圖
struct PendingReceiptView: View {
    var body: some View {
        List {
            ForEach(0..<3) { index in
                Text("待收貨訂單 \(index + 1)")
            }
        }
        .navigationBarTitle("待收貨", displayMode: .inline)
    }
}

// 收藏食譜視圖
struct FavoriteRecipesView: View {
    var body: some View {
        List {
            ForEach(0..<4) { index in
                Text("食譜 \(index + 1)")
            }
        }
        .navigationBarTitle("收藏食譜", displayMode: .inline)
    }
}

// 收藏商品視圖
struct FavoriteProductsView: View {
    var body: some View {
        List {
            ForEach(0..<5) { index in
                Text("商品 \(index + 1)")
            }
        }
        .navigationBarTitle("收藏商品", displayMode: .inline)
    }
}

// 兌換禮品卡或代碼視圖
struct RedeemGiftCardView: View {
    var body: some View {
        Form {
            Section {
                TextField("禮品卡或代碼", text: .constant(""))
                Button("兌換") {
                    // 兌換操作
                }
            }
        }
        .navigationBarTitle("兌換禮品卡或代碼", displayMode: .inline)
    }
}

// 個人化推薦視圖
struct PersonalizedRecommendationsView: View {
    var body: some View {
        List {
            ForEach(0..<5) { index in
                Text("推薦 \(index + 1)")
            }
        }
        .navigationBarTitle("個人化推薦", displayMode: .inline)
    }
}

// 應用設置視圖
struct AppSettingsView: View {
    var body: some View {
        Form {
            Section(header: Text("通知設置")) {
                Toggle("接收通知", isOn: .constant(true))
            }
            Section(header: Text("其他設置")) {
                Toggle("使用暗黑模式", isOn: .constant(false))
            }
        }
        .navigationBarTitle("應用設置", displayMode: .inline)
    }
}

// 幫助與支持視圖
struct HelpSupportView: View {
    var body: some View {
        List {
            Text("常見問題")
            Text("聯繫我們")
        }
        .navigationBarTitle("幫助與支持", displayMode: .inline)
    }
}

#Preview {
    AccountView()
}
