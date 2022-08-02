//
//  HotDogClassificationController.swift
//  SeeFood-Swift
//
//  Created by Cory Carte on 7/23/22.
//

import Foundation
import CoreML
import Vision
import UIKit

class HotDogClassifier {
    let model: VNCoreMLModel
    
    var classificationResult: HdResult?
    
    init() {
        let config = MLModelConfiguration()
        guard let model = try? VNCoreMLModel(for: Inceptionv3(configuration: config).model) else {
            fatalError("Error loading InceptionV3 model")
        }
        
        self.model = model
    }
    
    func classify(_ image: UIImage?) {
        if image == nil {
            print("nil image can't be classified")
            return
        }
        
        print("Starting image classification")
        guard let ciImage = CIImage(image: image!) else {
            fatalError("Error converting UIImage to CIImage")
        }
        
        let request = VNCoreMLRequest(model: model) { (request, error) in
            if error != nil {
                print("Image detection error: \(error!)")
            }
            
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("Model has failed to process image")
            }
            
            if let topResults = results.last(where: {$0.confidence >= 0.20}) {
                print(topResults)
            }
            
            if let firstResult = results.first {
                if firstResult.identifier.contains("hotdog") {
                    self.classificationResult = HdResult(.hotdog)
                } else {
                    self.classificationResult = HdResult(.nothoddog)
                }
            }
        }
        
        let handler = VNImageRequestHandler(ciImage: ciImage)
        
        do {
            try handler.perform([request])
        } catch {
            print("detection handler error: \(error)")
        }
    }
}
