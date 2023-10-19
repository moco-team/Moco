//
//  HomeView.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 11/10/23.
//

import SwiftData
import SwiftUI
import MediaPlayer

struct HomeView: View {
    @Environment(\.audioViewModel) private var audioViewModel
    @Environment(\.timerViewModel) private var timerViewModel
    
    @Environment(\.itemViewModel) private var itemViewModel
    @Environment(\.navigate) private var navigate
    
    @State private var soundLevel: Float = 0.5
    
    var body: some View {
        ZStack {
            Image("Story/main-background")
                .resizable()
                .scaledToFill()
                .frame(width: Screen.width, height: Screen.height, alignment: .center)
                .clipped()
            
            VStack {
                HStack(alignment: .center) {
                    Image("Story/nav-icon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 0.4 * Screen.width)
                        .padding(.top, 50)
                        
                    Spacer()
                    
                    Button(action: {}) {
                        Image("Story/Icons/burger-menu")
                            .resizable()
                            .frame(width: 90, height: 90)
                    }
                }
                .padding(.horizontal, 0.05 * Screen.width)
                
                Spacer()
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: [GridItem(.flexible())]) {
                        ForEach(itemViewModel.items) { item in
                            StoryBook(title: item.name) {
                                navigate.append(.story("Bangers"))
                            }
                        }
                    }
                    .padding(.horizontal, 30)
                }.scrollClipDisabled()
                
                Spacer()
                Spacer()
            }
            .onAppear {
                //                audioViewModel.playSound(soundFileName: "bg-story", numberOfLoops: -1)
                MPVolumeView.setVolume(self.soundLevel)
            }
        }
    }
}

#Preview {
    @State var itemViewModel = ItemViewModel()
    
    return HomeView().environment(\.itemViewModel, itemViewModel)
}
