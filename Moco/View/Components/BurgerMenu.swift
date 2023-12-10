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
    @State var isGameCenterAchievementsPresented = false

    var size: CGFloat {
        UIDevice.isIPad ? 90 : 60
    }

    var expandedSize: CGFloat {
        UIDevice.isIPad ? 50 : 35
    }

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
                                .frame(width: size, height: size)
                                .shadow(radius: 4, x: -2, y: 2)
                                .onTapGesture {
                                    isGameCenterAchievementsPresented = true
                                }
                                .fullScreenCover(isPresented: $isGameCenterAchievementsPresented) {
                                    GameCenterView(viewState: .achievements).ignoresSafeArea()
                                }
                        }
                        SfxButton {
                            navigate.append(.settings)
                        } label: {
                            Image("Story/Icons/settings")
                                .resizable()
                                .frame(width: size, height: size)
                                .shadow(radius: 4, x: -2, y: 2)
                        }
                    }.padding(.vertical, UIDevice.isIPad ? 18 : 12)
                        .padding(.leading, UIDevice.isIPad ? 20 : 15)
                        .padding(.trailing, UIDevice.isIPad ? 10 : 7)
                }
                SfxButton {
                    withAnimation(.spring()) {
                        self.expand.toggle()
                    }
                } label: {
                    Image(expand ? "Story/Icons/burger-menu-opened" : "Story/Icons/burger-menu")
                        .resizable()
                        .frame(
                            width: expand ? expandedSize : size,
                            height: expand ? expandedSize : size
                        )
                        .shadow(radius: 4, x: -2, y: 2)
                }
                .padding(.trailing, UIDevice.isIPad ? 20 : 10)
            }
            .background(expand ? .white : .clear)
            .cornerRadius(UIDevice.isIPad ? 38 : 24)
        }
    }
}

#Preview {
    VStack {
        BurgerMenu()
    }.frame(width: .infinity, height: .infinity).background(.black)
}
