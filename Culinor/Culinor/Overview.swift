import SwiftUI
import SwiftUICharts

struct OverView: View {
    var demoData: [Double] = [ 8, 2, 4, 6, 12, 9, 2]
    
    @State private var showModal = false
    @State private var showAddModal = false
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        // Chart
                        CardView {
                            VStack(alignment: .leading) {
                                HStack {
                                    ChartLabel("Total: 20", type: .subTitle, format: "Total: %.0f")
                                }
                                BarChart()
                            }
                            .padding()
                            .background(Color.systemBackground)
                        }
                        .data(demoData)
                        .chartStyle(ChartStyle(backgroundColor: Color.systemBackground, foregroundColor: ColorGradient(Color.icon.opacity(0.4), Color.chart)))
                        .frame(height: 300)
                        
                        // List
                        RecentStorageList()
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                }
                .background(Color.Background)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        HStack(alignment: .firstTextBaseline) {
                            Text("Overview")
                                .font(.title)
                                .bold()
                            Text(getFormattedDate())
                                .font(.title3)
                                .foregroundColor(.gray)
                        }
                        .padding(.top, 9)
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            showModal = true
                            print("User profile tapped")
                        } label: {
                            Image("user_profile") // 使用你自己的頭貼圖片名稱
                                .resizable()
                                .scaledToFit()
                                .clipShape(Circle())
                                .frame(width: 60, height: 60) // 設置頭貼圖片的大小
                        }
                        .sheet(isPresented: $showModal) {
                            AccountView()
                        }
                    }
                }
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            showAddModal = true
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .frame(width: 60, height: 60)
                                .background(Color.white)
                                .clipShape(Circle())
                                .shadow(radius: 10)
                                .padding()
                        }
                        .sheet(isPresented: $showAddModal) {
                            AddItemView()
                        }
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
        .accentColor(Color.icon)
    }

    func getFormattedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "zh_Hant_TW") //設置繁體中文區域
        dateFormatter.dateFormat = "M月d日" // 自訂日期格式
        return dateFormatter.string(from: Date())
    }
}

// 示例的AddItemView
struct AddItemView: View {
    var body: some View {
        Text("Add Item View")
            .font(.largeTitle)
            .padding()
    }
}

struct OverviewView_Previews: PreviewProvider {
    static let storageListVM: StorageListViewModel = {
        let storageListVM = StorageListViewModel()
        storageListVM.storage = storageListPreviewData
        return storageListVM
    }()

    static var previews: some View {
        OverView()
            .environmentObject(storageListVM)
    }
}
