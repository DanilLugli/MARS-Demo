import SwiftUI
import MARS
import RoomPlan
import SceneKit
import ARKit

struct HomeView: View {
    @State private var navigateToLocationView: Bool = false
    @State private var locationProvider: LocationProvider?
    var arView = ARSCNView()
    var url = URL(fileURLWithPath: "path/to/directory") 
    
    var body: some View {
        NavigationView {
            VStack {
                Button(action: {
                    Task {
                        
                        let provider = await LocationProvider(arView: arView, url: url)
                        locationProvider = provider
                        navigateToLocationView = true
                        
                    }
                }) {
                    Text("START NAVIGATION")
                        .frame(width: 200, height: 60)
                        .foregroundStyle(.white)
                        .background(Color.blue.opacity(0.4))
                        .cornerRadius(20)
                        .bold()
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .foregroundColor(.white)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .background(Color.customBackground)
            .edgesIgnoringSafeArea(.all)
            .navigationTitle("ARL Navigation")
            .navigationDestination(isPresented: $navigateToLocationView) {
                if let locationProvider = locationProvider {
                    LocationView(locationProvider: locationProvider)
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
