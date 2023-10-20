//
//  HintModalAdminView.swift
//  Moco
//
//  Created by Nur Azizah on 19/10/23.
//

import SwiftUI

struct HintModalAdminView: View {
    @Environment(\.storyViewModel) private var storyViewModel
    @Environment(\.promptViewModel) private var promptViewModel
    @Environment(\.hintViewModel) private var hintViewModel
    
    @Binding var isHintPresented: Bool
    
    @State private var hint: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Add hint for page \(storyViewModel.selectedStoryPage!.pageNumber) and prompt \(promptViewModel.selectedPrompt!.promptType)")) {
                        TextField("Hint...", text: $hint)
                    }
                }
                
                VStack {
                    ForEach (Array(hintViewModel.hints.enumerated()), id:\.1) { index, hint in
                        
                        HStack {
                            Text("\(index+1). \(hint.hint)")
                            
                            
                            Button(action: {
                                hintViewModel.deleteHint(prompt: promptViewModel.selectedPrompt!, hint: hint)
                            }, label: {
                                Image("trash.fill")
                                    .background(Color.red)
                            })
                        }
                        
                    }
                }
            }
            .navigationBarItems(
                leading:
                    Button("Cancel") {
                        isHintPresented = false
                    },
                trailing:
                    Button("Add hint") {
                        hintViewModel.createHint(promptViewModel.selectedPrompt!, hint: hint)
                        isHintPresented = false
                    }
            )
            .navigationTitle("Modal Sheet Form")
        }
    }
}

#Preview {
    HintModalAdminView(isHintPresented: .constant(true))
}
