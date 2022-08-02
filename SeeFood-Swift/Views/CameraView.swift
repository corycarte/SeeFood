//
//  CameraView.swift
//  SeeFood-Swift
//
//  Created by Cory Carte on 7/30/22.
//

import SwiftUI
import AVFoundation

struct CameraView: UIViewRepresentable {
    class VideoPreview: UIView {
        override class var layerClass: AnyClass {
                     AVCaptureVideoPreviewLayer.self
                }
                
                var videoPreviewLayer: AVCaptureVideoPreviewLayer {
                    return layer as! AVCaptureVideoPreviewLayer
                }
    }
    
    let session: AVCaptureSession
    
    func makeUIView(context: Context) -> VideoPreview {
            let view = VideoPreview()
            view.backgroundColor = .black
            view.videoPreviewLayer.cornerRadius = 0
            view.videoPreviewLayer.session = session
            view.videoPreviewLayer.connection?.videoOrientation = .portrait

            return view
        }
        
        func updateUIView(_ uiView: VideoPreview, context: Context) {
            
        }
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView(session: AVCaptureSession())
            .frame(height: 500)
    }
}
