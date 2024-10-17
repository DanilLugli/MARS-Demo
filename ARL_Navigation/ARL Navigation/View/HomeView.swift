import SwiftUI
import MARS
import RoomPlan
import SceneKit
import ARKit

struct HomeView: View {
    
    @State private var locationProvider: PositionProvider? = nil
    @State private var arView = ARSCNView()
    
    var body: some View {
        NavigationView { // Aggiungi NavigationView per la toolbar
            VStack {
                if let provider = locationProvider {
                    provider.showMap()
                        .ignoresSafeArea()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    VStack {
                        // Testo descrittivo sopra il bottone
                        Text("ARL Navigation is an app that demonstrates the functionality of the MARS library. Press the button below to Start end to be mapped and localized in the EveryWare Lab map.")
                            .font(.body)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 20)
                            .padding(.bottom, 20)
                        
                        Button(action: {
                            Task {
                                let fileManager = FileManager.default
                                let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("ARLNavigation")
                                
                                if !fileManager.fileExists(atPath: documentsDirectory.path) {
                                    do {
                                        try fileManager.createDirectory(at: documentsDirectory, withIntermediateDirectories: true, attributes: nil)
                                        print("Directory created successfully")
                                    } catch {
                                        // Handle error
                                        print("Error creating directory: \(error)")
                                    }
                                }
                                
                                let casaDirectoryURL = documentsDirectory
                                let arSCNView = ARSCNView(frame: .zero) // Initialize ARSCNView
                                locationProvider = await PositionProvider(url: casaDirectoryURL, arSCNView: arView)
                            }
                        }) {
                            Text("Upload Map & Start Navigation")
                                .font(.headline)
                                .foregroundColor(.blue) // Text color
                                .frame(width: 280, height: 80) // Button size
                                .background(Color.blue.opacity(0.4)) // Background with opacity
                                .cornerRadius(20) // Rounded corners
                        }
                    }
                    .padding()
                    .navigationTitle("ARL Navigation")
                }
            }
        }
    }
}
