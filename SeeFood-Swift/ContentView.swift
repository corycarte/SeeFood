//
//  ContentView.swift
//  SeeFood-Swift
//
//  Created by Cory Carte on 7/23/22.
//

import SwiftUI

struct ContentView: View {
    @State private var result: HdResult = HdResult(HdCheckResult.nothoddog)
    @State private var buttonText: String = "HotDog?"
    @State private var showResult: Bool = false
    @State private var inputImage: UIImage?
    @State private var hotdogImage: Image? = Image("perfect-hot-dog")
    @State private var showPicker = false
    @State private var imageSource = UIImagePickerController.SourceType.photoLibrary
    
    private let classifier = HotDogClassifier()
    
    private func getCircleImage() -> String {
        if imageSource == .camera {
            return "camera"
        }
        
        return "photo"
    }
    private func loadImage() {
        guard let inputImage = self.inputImage else { return }
        self.hotdogImage = Image(uiImage: inputImage)
    }
    
    private func buttonPressed() -> HdResult {
        
        var checkResult: HdCheckResult?
        
        // Test code to make sure all results render
        switch(self.result.result) {
        case HdCheckResult.hotdog:
            checkResult = HdCheckResult.maybehotdog
        case HdCheckResult.maybehotdog:
            checkResult = HdCheckResult.nothoddog
        default:
            checkResult = HdCheckResult.hotdog
        }
        
        return HdResult(checkResult!)
    }

    var body: some View {
        ZStack {
            VStack {
                hotdogImage?
                    .resizable()
                    .ignoresSafeArea()
                    .aspectRatio(contentMode: .fill)
                HStack {
                    Spacer()
                    Button(action: {
//                        if imageSource == .camera {
//                            imageSource = .photoLibrary
//                        } else {
//                            imageSource = .camera
//                        }
                    }, label: {
                        Circle()
                            .foregroundColor(.blue)
                            .frame(width: 75, height: 75)
                            .overlay(
                                Image(systemName: getCircleImage())
                                    .scaledToFill()
                                    .foregroundColor(.white))
                    })
                    Spacer()
                    Button(action: {
                        self.showResult = false
                        showPicker = true
                    }, label: {
                        RoundedRectangle(cornerRadius: 50)
                            .frame(width: 200, height: 75)
                            .foregroundColor(.black)
                            .overlay(Text(self.buttonText).foregroundColor(.white))
                    })
                    Spacer()
                }
                .frame(minHeight: 50, idealHeight: 100, maxHeight: 100)
            }
            VStack {
                Spacer()
                if self.showResult {
                    self.result
                } else {
                    self.result.hidden()
                }
                Spacer()
            }
        }.sheet(isPresented: $showPicker) {
            CameraService(image: self.$inputImage, sourceType: self.imageSource)
        }.onChange(of: inputImage) { _ in
            loadImage()
            classifier.classify(self.inputImage)
            self.result = classifier.classificationResult ?? HdResult(.maybehotdog)
            showResult = true
        }
        .background(.gray)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 13 Pro")
    }
}
