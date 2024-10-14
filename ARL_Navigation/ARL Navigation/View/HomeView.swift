import SwiftUI
import MARS
import RoomPlan
import SceneKit
import ARKit

struct HomeView: View {
    @State private var navigateToLocationView: Bool = false
    @State private var locationProvider: LocationProvider?
    @State var arView = ARSCNView()
    @State private var navigationPath = NavigationPath()

    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack {
                VStack{

//                    VStack{
//                        Text("Building:").font(.largeTitle)
//                        Text(locationProvider?.building?.name ?? "")
//                        //Text(locationProvider.building?.floors.count ?? 99)
//                        //Text(locationProvider.building?.floors[0].rooms.count)
//                        Text("Floors:").font(.title2)
//                        Text(locationProvider!.building?.floors[0].name ?? "")
//                        Text("Rooms:").font(.title2)
//                        Text(locationProvider!.building?.floors[0].rooms[0].name ?? "")
//                        Text(locationProvider!.building?.floors[0].rooms[1].name ?? "")
//                        Text("Scene:").font(.title2)
//                        Text(locationProvider!.building?.floors[0].scene.description ?? "Error for floor scene")
//                        Text(locationProvider!.building?.floors[0].rooms[1].scene.description ?? "Error for floor scene")
//                    }
                }
                Button(action: {
                    Task {
                        let fileManager = FileManager.default
                        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("ARLNavigation")
                        
                        if !fileManager.fileExists(atPath: documentsDirectory.path) {
                            do {
                                try fileManager.createDirectory(at: documentsDirectory, withIntermediateDirectories: true, attributes: nil)
                                print("Root folder created: \(documentsDirectory.path)")
                            } catch {
                                throw NSError(domain: "com.example.ScanBuild", code: 1, userInfo: [NSLocalizedDescriptionKey: "Error creating root folder: \(error)"])
                            }
                        }

                        let casaDirectoryURL = documentsDirectory
                        let provider = await LocationProvider(arView: arView, url: casaDirectoryURL)
                        locationProvider = provider
                        navigateToLocationView = true

                        // Use navigation path to push LocationView onto the stack
                        navigationPath.append(locationProvider!)
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
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .background(Color.customBackground)
            .edgesIgnoringSafeArea(.all)
            .navigationTitle("ARL Navigation")
            .foregroundColor(.white)
            .navigationDestination(for: LocationProvider.self) { locationProvider in
                LocationView(locationProvider: locationProvider)
            }
        }
    }
}

#Preview {
    HomeView()
}
