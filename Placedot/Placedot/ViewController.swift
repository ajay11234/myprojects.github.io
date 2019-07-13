//
//  ViewController.swift
//  Placedot
//
//  Created by Ajay on 6/19/18.
//  Copyright © 2018 Ajay. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController,ARSCNViewDelegate {

    @IBOutlet weak var scnView: ARSCNView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        scnView.delegate = self
        
        let scene = SCNScene()
       
        scnView.showsStatistics = true
        
        scnView.scene = scene
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        // Run the view's session
        scnView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        scnView.session.pause()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touches = touches.first else { return }
        let hitest = scnView.hitTest(touches.location(in: scnView), types: [ARHitTestResult.ResultType.featurePoint])
        guard let hitfeature = hitest.last else { return }
        let hitTransform = SCNMatrix4.init(hitfeature.worldTransform)
        let hitPosition = SCNVector3Make(hitTransform.m41,hitTransform.m42,hitTransform.m43)
        
        createball(hitPosition: hitPosition)
        
    }
    
    func createball(hitPosition: SCNVector3){
        
        let sphere = SCNSphere(radius: 0.01)
        let sphereNode = SCNNode(geometry: sphere)
        sphereNode.position = hitPosition
        self.scnView.scene.rootNode.addChildNode(sphereNode)
    
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

