import SwiftUI
import MARS
import RoomPlan
import SceneKit
import ARKit

struct HomeView: View {
    
    @State private var locationProvider: PositionProvider? = nil
    @State private var arView = ARSCNView()
    
    // Istanza del multiplexer per gestire più delegate
    private let delegateMultiplexer = ARSCNDelegateMultiplexer()
    
    var body: some View {
        NavigationView {
            VStack {
                if let provider = locationProvider {
                    provider.showMap()
                        .ignoresSafeArea()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    VStack {
                        Image(systemName: "iphone.gen2.badge.location")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundStyle(Color.blue.opacity(0.6), Color.blue)
                            .frame(width: 100, height: 100)
                        
                        Text("ARL Navigation is an app that demonstrates MARS library's functionality in debug mode. \nPress the button below to Start end being mapped and localized in the EveryWare Lab environment.\nAll the data used in this app in order to be located with MARS are created with ARL Creator.")
                            .font(.body)
                            .padding(.top)
                        
                        Spacer()
                        
                        Button(action: {
                            Task {
                                // Creazione della directory se non esiste
                                let fileManager = FileManager.default
                                let dataFromURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("ARLNavigation")
                                
                                if !fileManager.fileExists(atPath: dataFromURL.path) {
                                    do {
                                        try fileManager.createDirectory(at: dataFromURL, withIntermediateDirectories: true, attributes: nil)
                                    } catch {
                                        print("Error creating directory: \(error)")
                                    }
                                }
                                
                                let data = dataFromURL
                                
                                arView.automaticallyUpdatesLighting = true
                                
                                let markerLogger = MarkerLoggingDelegate()
                                
                                delegateMultiplexer.addDelegate(markerLogger)
                                arView.delegate = delegateMultiplexer
                                
                                var referenceMarkersByLocation: [String: Set<ARReferenceImage>] = [:]
                                if let uiImage = UIImage(named: "Test_AR"),
                                   let cgImage = uiImage.cgImage {
                                    let referenceImage = ARReferenceImage(cgImage,
                                                                          orientation: .up,
                                                                          physicalWidth: 0.2)
                                    referenceMarkersByLocation["Lab"] = [referenceImage]
                                }
                                
                                await MainActor.run {
                                    locationProvider = PositionProvider(
                                        data: data,
                                        arSCNView: arView,
                                        referenceMarkersByLocation: referenceMarkersByLocation,
                                        worldMapConfigurationHandler: { config in
                                            config.planeDetection = [.horizontal]
                                            config.worldAlignment = .gravity
                                            if let labImages = referenceMarkersByLocation["Lab"] {
                                                config.detectionImages = labImages
                                            }
                                        }
                                    )
                                }
                                
                                if let currentMultiplexer = arView.delegate as? ARSCNDelegateMultiplexer {
                                    currentMultiplexer.addDelegate(markerLogger)
                                }
                            }
                        }) {
                            Text("Start Positioning")
                                .font(.system(size: 24))
                                .bold()
                                .font(.headline)
                                .foregroundColor(.blue)
                                .frame(width: 280, height: 80)
                                .background(Color.blue.opacity(0.2))
                                .cornerRadius(20)
                        }
                    }
                    .padding()
                    .navigationTitle("ARL Navigation")
                }
            }
        }
    }
}



struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
