//
//  JosefineSans.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 31/10/23.
//

import SwiftUI

struct AppJosefineSans: View {
    var text: String = ""
//    var josepSize: fontType
    var size: Font
    var fontWeight: Font.Weight = Font.Weight.medium
    var fontColor: Color = Color.black
    var textAligment: TextAlignment = .center
    

    var body: some View {
        Text(text)
//            .font(.josefinSans(.regular, size: josepSize))
            .font(size)
            .fontWeight(fontWeight)
            .foregroundColor(fontColor)
            .multilineTextAlignment(textAligment)
    }
}

struct AppJosefineSans_Previews: PreviewProvider {
    static var previews: some View {
//        AppJosefineSans(text:"adsad", josepSize: fontType.regular)
        AppJosefineSans(text:"adsad", size: .largeTitle)
    }
}
