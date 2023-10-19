//
//  StoryThemeModalView.swift
//  Moco
//
//  Created by Nur Azizah on 18/10/23.
//

import SwiftUI

struct StoryThemeModalView: View {
    @Environment(\.storyThemeViewModel) private var storyThemeViewModel
    
    @Binding var isPresented: Bool
    @State private var pictureName: String = ""
    @State private var descriptionTheme: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Add Story Theme")) {
                    TextField("Picture name...", text: $pictureName)
                    
                    TextField("Description theme...", text: $descriptionTheme)
                }
            }
            .navigationBarItems(
                leading: Button("Cancel") {
                    isPresented = false
                },
                trailing: Button("Save") {
                    storyThemeViewModel.createStoryTheme(stories: [], pictureName: pictureName, descriptionTheme: descriptionTheme)
                    isPresented = false
                }
            )
            .navigationTitle("Modal Sheet Form")
        }
    }
}

#Preview {
    @State var storyThemeViewModel = StoryThemeViewModel()
    
    return StoryThemeModalView(isPresented: .constant(true)).environment(\.storyThemeViewModel, storyThemeViewModel)
}
