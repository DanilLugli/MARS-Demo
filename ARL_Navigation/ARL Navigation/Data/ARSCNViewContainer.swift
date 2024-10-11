import Foundation
import ARKit
import SwiftUI

struct ARSCNViewContainer: UIViewRepresentable {
    
    // Variabile per la libreria che gestisce ARSCNView
    var arscnDelegate: ARSCNViewDelegate
    
    var sceneView = ARSCNView(frame: .zero)
    
    func makeUIView(context: Context) -> ARSCNView {
        
        sceneView.delegate = arscnDelegate
        return sceneView
    }
    
    func updateUIView(_ uiView: ARSCNView, context: Context) {
        
    }
}
