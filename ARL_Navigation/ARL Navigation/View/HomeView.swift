import SwiftUI
import MARS
import RoomPlan
import SceneKit
import ARKit

struct HomeView: View {
    
    var url: URL = URL(fileURLWithPath: "ARL Creator/ARLCreator/Dipartimento Informatica")
    @State private var navigateToLocationView = false  // Variabile per controllare la navigazione

    public init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(Color.customBackground)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }

    var body: some View {
        NavigationStack { // Usa NavigationStack per iOS 16+
            VStack(alignment: .leading) {

                Text("ARL Navigation is an app designed to demonstrate how to use the MARS library.\n\nMARS is a library that provides to end-user their position within environments that have been scanned, processed, and created through ARL Creator.")
                    .padding()

                Divider()
                
                VStack {
                    Button(action: {
                        navigateToLocationView = true  // Attiva la navigazione
                    }) {
                        Text("START NAVIGATION")
                            .frame(width: 200, height: 60)
                            .foregroundStyle(.white)
                            .background(Color.blue.opacity(0.4))
                            .cornerRadius(20)
                            .bold()
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center) // Posiziona al centro
            }
            .foregroundColor(.white)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .background(Color.customBackground)
            .edgesIgnoringSafeArea(.all)
            .navigationTitle("ARL Navigation")
            .navigationDestination(isPresented: $navigateToLocationView) {
                LocationView()  // La vista di destinazione
            }
        }
    }
}

#Preview {
    HomeView()
}
