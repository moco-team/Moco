//
//  BurgerMenu.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 20/10/23.
//

import SwiftUI

struct BurgerMenu: View {
    @Environment(\.navigate) private var navigate

    @State private var expand = false

    var body: some View {
        HStack(spacing: 0) {
            Spacer()
            HStack {
                if expand {
                    HStack {
                        SfxButton {
                            navigate.append(.achievements)
                        } label: {
                            Image("Story/Icons/achievements")
                                .resizable()
                                .frame(width: 90, height: 90)
                                .shadow(radius: 4, x: -2, y: 2)
                        }
                        SfxButton {
                            navigate.append(.settings)
                        } label: {
                            Image("Story/Icons/settings")
                                .resizable()
                                .frame(width: 90, height: 90)
                                .shadow(radius: 4, x: -2, y: 2)
                        }
                    }.padding(.vertical, 18)
                        .padding(.leading, 20)
                        .padding(.trailing, 10)
                }
                SfxButton {
                    withAnimation(.spring()) {
                        self.expand.toggle()
                    }
                } label: {
                    Image(expand ? "Story/Icons/burger-menu-opened" : "Story/Icons/burger-menu")
                        .resizable()
                        .frame(width: expand ? 50 : 90, height: expand ? 50 : 90)
                        .shadow(radius: 4, x: -2, y: 2)
                }
                .padding(.trailing, 20)
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
