import SwiftUI
import MARS
import RoomPlan
import SceneKit
import ARKit

struct HomeView: View {
    
    @State private var locationProvider: PositionProvider? = nil
    @State private var arView = ARSCNView()
    
    var body: some View {
        VStack {
            if let provider = locationProvider {
                provider.showMap()
                Text((locationProvider?.building.name)!)
            } else {
                Button(action: {
                    Task {
                        let fileManager = FileManager.default
                        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("ARLNavigation")
                        
                        if !fileManager.fileExists(atPath: documentsDirectory.path) {
                            do {
                                try fileManager.createDirectory(at: documentsDirectory, withIntermediateDirectories: true, attributes: nil)
                                print("Directory creata correttamente")
                            } catch {
                                // Gestisci l'errore
                                print("Errore durante la creazione della directory: \(error)")
                            }
                        }
                        
                        let casaDirectoryURL = documentsDirectory
                        let arSCNView = ARSCNView(frame: .zero) // Inizializza ARSCNView
                        locationProvider = await PositionProvider(url: casaDirectoryURL, arSCNView: arView)
                        
                    }
                }) {
                    Text("Upload & Start Navigation")
                }
            }
        }
    }
}
