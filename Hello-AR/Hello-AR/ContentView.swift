//
//  ContentView.swift
//  Hello-AR
//
//  Created by Shiru99 on 30/03/23.
//

import SwiftUI
import RealityKit
import ARKit

struct ContentView : View {
    
    let modelNames = ["robot_walk_idle", "toy_biplane_idle", "toy_drummer_idle", "toy_car"]
    
    @State private var selectedModelIndex = 0
    @State private var isResetOn: Bool = false
    @State private var isSaveOn: Bool = false
    @State private var loadSaved: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                ARViewContainer(modelName: modelNames[selectedModelIndex], isResetOn: $isResetOn, isSaveOn: $isSaveOn, loadSaved: $loadSaved)
                    .edgesIgnoringSafeArea(.all)
                
                
                Picker("Select Model", selection: $selectedModelIndex) {
                    ForEach(0 ..< modelNames.count) { index in
                        Image(modelNames[index])
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .tag(index)
                    }
                }
                .frame(height: 100)
                .pickerStyle(SegmentedPickerStyle())
                .scaledToFit()
                .scaleEffect(CGSize(width: 0.5, height: 3.6))
                .padding(.bottom, 50)
                
            }.toolbar{
                ToolbarItemGroup(placement: .principal){
                    HStack(){
                        Button("Load") { loadSaved.toggle() }
                        Spacer()
                        Button("Reset") {
                            isResetOn.toggle()
                            selectedModelIndex = 0
                        }
                        Spacer()
                        Button("Save") { isSaveOn.toggle() }
                    }
                }
            }
        }
    }
}



struct ARViewContainer: UIViewRepresentable {
    let modelName: String
    
    @Binding var isResetOn: Bool
    @Binding var isSaveOn: Bool
    @Binding var loadSaved: Bool
    
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: UIScreen.main.bounds)
        arView.debugOptions.insert([.showAnchorOrigins, .showWorldOrigin])
        return arView
    }
    
    
    func setPropertiesToModelEntity(_ uiView: ARView, _ modelEntity: ModelEntity) {
        modelEntity.transform.translation.x = 0
        modelEntity.transform.translation.y = 0
        modelEntity.transform.translation.z = 0
        
        modelEntity.generateCollisionShapes(recursive: false)
        uiView.installGestures([.rotation, .translation, .scale], for: modelEntity)
        
        for animation in modelEntity.availableAnimations {
            modelEntity.playAnimation(animation.repeat())
        }
    }
    
    
    func place3DModel(_ uiView: ARView) {
        // AR Anchor
        let arAnchor = ARAnchor(name: modelName, transform: matrix_identity_float4x4)
        uiView.session.add(anchor: arAnchor)
        
        
        // Anchor Entitty
        let anchorEntity = AnchorEntity(anchor: arAnchor)
        anchorEntity.name = arAnchor.identifier.uuidString      // MUST
        uiView.scene.addAnchor(anchorEntity)
        
        
        // Model Entity
        let modelEntity: ModelEntity = try! ModelEntity.loadModel(named: modelName + ".usdz")
        setPropertiesToModelEntity(uiView, modelEntity)
        anchorEntity.addChild(modelEntity)
    }
    
    func resetState(_ uiView: ARView){
        uiView.scene.anchors.removeAll()
    }
    
    func saveState(_ uiView: ARView){
        ARStatePersistance.shared.save(uiView)
    }
    
    func loadState(_ uiView: ARView){
        ARStatePersistance.shared.load(uiView)
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        
        if(loadSaved){
            resetState(uiView)
            loadState(uiView)
            loadSaved.toggle()
            return
        }
        
        if(isSaveOn){
            saveState(uiView)
            resetState(uiView)
            isSaveOn.toggle()
            return
        }
        
        if(isResetOn){
            resetState(uiView)
            isResetOn.toggle()
            return
        }
        
        place3DModel(uiView)
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
