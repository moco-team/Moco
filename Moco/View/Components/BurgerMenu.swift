//
//  BurgerMenu.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 20/10/23.
//

import SwiftUI

struct BurgerMenu: View {
    @State private var expand = false

    var body: some View {
        HStack(spacing: 0) {
            Spacer()
            HStack {
                if expand {
                    HStack {
                        Image("Story/Icons/burger-menu")
                            .resizable()
                            .frame(width: 90, height: 90)
                        Image("Story/Icons/burger-menu")
                            .resizable()
                            .frame(width: 90, height: 90)
                    }.padding(.vertical, 18)
                        .padding(.leading, 20)
                }
                Button {
                    withAnimation(.spring()) {
                        self.expand.toggle()
                    }
                } label: {
                    Image("Story/Icons/burger-menu")
                        .resizable()
                        .frame(width: 90, height: 90)
                }
            }
            .background(expand ? .white : .clear)
            .cornerRadius(38)
        }
    }
}

#Preview {
    VStack {
        BurgerMenu()
    }.frame(width: .infinity, height: .infinity).background(.black)
}
