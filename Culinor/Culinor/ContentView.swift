import SwiftUI
import SwiftUICharts

struct ContentView: View {
    init() {
        UITabBar.appearance().backgroundColor = UIColor.lightText
    }

    var body: some View {
        TabView {
            OverView()
                .tabItem {
                    Image(systemName: "house")
                    Text("首頁")
                }
            ListView(recipeManager: RecipeManager())
                .tabItem {
                    Image(systemName: "fork.knife")
                    Text("食譜")
                }
//            OrderView()
//                .tabItem {
//                    Image(systemName: "bag")
//                    Text("訂單")
//                }
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("訂單")
                }
        }
        .navigationBarHidden(true)
        .accentColor(Color.green) // Set the selected item color
    }
}

//#Preview {
//    ContentView()
//}

struct ContentView_Previews: PreviewProvider {
    static let storageListVM: StorageListViewModel = {
        let storageListVM = StorageListViewModel()
        storageListVM.storage = storageListPreviewData
        return storageListVM
    }()
    
    static var previews: some View {
        ContentView()
            .environmentObject(storageListVM)
    }
}


// 示例視圖
//struct ListView: View {
//    var body: some View {
//        Text("列表頁面")
//    }
//}
//
//struct OrderView: View {
//    var body: some View {
//        Text("訂單頁面")
//    }
//}
//
//struct SearchView: View {
//    var body: some View {
//        Text("搜尋頁面")
//    }
//}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
