import SwiftUI

struct WelcomeView: View {
    @State private var selection = 0
    
    var body: some View {
        NavigationView {
            TabView(selection: $selection) {
                PageView(
                    imageName: "FoodStorage",
                    title: "Food Storage",
                    description: "Track and categorize groceries\nMonitor and remind expiration dates\nKeep your kitchen well-organized",
                    pageIndex: 0,
                    selection: $selection
                )
                .tag(0)
                
                PageView(
                    imageName: "FoodRecipe",
                    title: "Food Recipe",
                    description: "Find recipes based on available ingredients\nFilters include dietary preferences\nStep-by-step instructions and information",
                    pageIndex: 1,
                    selection: $selection
                )
                .tag(1)
                
                PageView(
                    imageName: "FoodDelivery",
                    title: "Food Delivery",
                    description: "Wide range of fresh, high-quality ingredients\nDirect delivery to your doorstep\nMaking cooking more convenient",
                    pageIndex: 2,
                    selection: $selection
                )
                .tag(2)
            }
            .tabViewStyle(PageTabViewStyle())
            .navigationBarHidden(true)
        }
    }
}

struct PageView: View {
    var imageName: String
    var title: String
    var description: String
    var pageIndex: Int
    @Binding var selection: Int
    
    var body: some View {
        VStack {
            Spacer()
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 300)
                .padding()
            Spacer()
            Text(title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 10)
            Text(description)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            Spacer()
            HStack {
                Spacer()
                ForEach(0..<3) { index in
                    Image(systemName: "circle.fill")
                        .foregroundColor(index == pageIndex ? Color.Text : .gray)
                }
                Spacer()
            }
            .padding(.bottom, 20)
            if pageIndex < 2 {
                Button(action: {
                    withAnimation {
                        selection += 1
                    }
                }) {
                    Image(systemName: "chevron.right.circle.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(Color.chart)
                        .padding(.bottom, 40)
                }
            } else {
                NavigationLink(destination: ContentView()) {
                    Text("Get Started")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.chart)
                        .cornerRadius(10)
                        .padding(.bottom, 40)
                }
            }
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static let storageListVM: StorageListViewModel = {
        let storageListVM = StorageListViewModel()
        storageListVM.storage = storageListPreviewData
        return storageListVM
    }()
    
    static var previews: some View {
        WelcomeView()
            .environmentObject(storageListVM)
    }
}
