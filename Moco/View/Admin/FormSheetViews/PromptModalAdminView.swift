//
//  PromptModalAdminView.swift
//  Moco
//
//  Created by Nur Azizah on 19/10/23.
//

import SwiftUI

struct PromptModalAdminView: View {
    @Environment(\.storyViewModel) private var storyViewModel
    @Environment(\.promptViewModel) private var promptViewModel
    @Environment(\.hintViewModel) private var hintViewModel
    
    @Binding var isPromptPresented: Bool
    @State var isHintPresented: Bool = false
    @State private var promptDescription: String = ""
    @State private var correctAnswer: String = ""
    @State private var duration: String = ""
    
    @State private var promptType: Int = 0
    let promptTypeOptions = ["Speech Detection", "Find Animated Object", "Object Detection"]
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Add prompt for page \(storyViewModel.selectedStoryPage!.pageNumber)")) {
                        TextField("Prompt Description...", text: $promptDescription)
                        
                        TextField("Correct Answer...", text: $correctAnswer)
                        
                        TextField("Duration...", text: $duration)
                        
                        VStack {
                            Text("Prompt Type")
                            Picker("Prompt Type...", selection: $promptType) {
                                ForEach(0 ..< promptTypeOptions.count, id: \.self) { index in
                                    Text(String(promptTypeOptions[index])).tag(index)
                                }
                            }
                            .pickerStyle(.wheel)
                        }
                    }
                }
                
                VStack {
                    ForEach (Array(promptViewModel.prompts.enumerated()), id:\.1) { index, prompt in
                        
                        HStack {
                            Text("\(prompt.promptDescription) - \(prompt.correctAnswer) - \(prompt.duration) - \(prompt.promptType)")
                            
                            
                            Button(action: {
                                promptViewModel.deletePrompt(prompt: prompt, story: storyViewModel.selectedStoryPage!)
                            }, label: {
                                Image("trash.fill")
                                    .background(Color.red)
                            })
                            
                            Button(action: {
                                promptViewModel.setSelectedPromptPage(index)
                                
                                hintViewModel.fetchHints(promptViewModel.selectedPrompt)
                                isHintPresented.toggle()
                            }, label: {
                                Image("square.and.arrow.up.circle.fill")
                                    .background(Color.blue)
                            })
                        }
                        
                    }
                }
            }
            .navigationBarItems(
                leading:
                    Button("Cancel") {
                        isPromptPresented = false
                    },
                trailing:
                    Button("Add prompt") {
                        promptViewModel.createPrompt(hints: [], story: storyViewModel.selectedStoryPage!, promptDescription: promptDescription, correctAnswer: correctAnswer, duration: Double(duration)!, promptType: promptTypeOptions[promptType])
                        isPromptPresented = false
                    }
            )
            .navigationTitle("Modal Sheet Form")
            .sheet(isPresented: $isHintPresented) {
                HintModalAdminView(isHintPresented: $isHintPresented)
            }
        }
    }
}

#Preview {
    PromptModalAdminView(isPromptPresented: .constant(true))
}
