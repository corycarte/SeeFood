//
//  HdResult.swift
//  SeeFood-Swift
//
//  Created by Cory Carte on 7/24/22.
//

import SwiftUI

enum HdCheckResult: String {
    case hotdog = "checkmark.seal.fill"
    case nothoddog = "multiply.circle.fill"
    case maybehotdog = "questionmark.circle.fill"
}

struct HdResult: View {
    let result: HdCheckResult
    let imgSize: CGFloat
    
    private func getText(_ img: HdCheckResult) -> String {
        switch(img) {
        case HdCheckResult.hotdog:
            return "Hot Dog!!"
        case HdCheckResult.nothoddog:
            return "Not Hot Dog..."
        default:
            return "Hotdog?"
        }
    }
    
    private func getColor(_ res: HdCheckResult) -> Color {
        switch(res) {
        case HdCheckResult.hotdog:
            return .green
        case HdCheckResult.nothoddog:
            return .red
        default:
            return .yellow
        }
    }
    
    init (_ res: HdCheckResult, imgSize: CGFloat = 250) {
        self.result = res
        self.imgSize = imgSize
    }
    
    var body: some View {
        Image(systemName: self.result.rawValue).resizable().foregroundColor(getColor(self.result)).frame(width: self.imgSize, height: self.imgSize).overlay(
            Rectangle()
                .cornerRadius((self.imgSize / 2))
                .frame(width: (self.imgSize), height: (self.imgSize / 3))
                .position(x: (self.imgSize / 2), y: (self.imgSize / 2) + (self.imgSize / 4))
                .foregroundColor(.cyan).overlay(
                    Text(self.getText(self.result))
                        .font(.system(size: (self.imgSize / 8)))
                        .foregroundColor(.white)
                        .position(x: (self.imgSize / 2), y: (self.imgSize / 2) + (self.imgSize / 4))
                ))
    }
}

struct HdResult_Previews: PreviewProvider {
    static var previews: some View {
        HdResult(HdCheckResult.hotdog).previewLayout(.sizeThatFits)
        HdResult(HdCheckResult.nothoddog).previewLayout(.sizeThatFits)
        HdResult(HdCheckResult.maybehotdog).previewLayout(.sizeThatFits)
    }
}
