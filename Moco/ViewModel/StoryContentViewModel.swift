//
//  StoryContentViewModel.swift
//  Moco
//
//  Created by Nur Azizah on 16/10/23.
//

import Foundation
import SwiftData
import SwiftUI

@Observable class StoryContentViewModel: BaseViewModel {
    static var shared = StoryContentViewModel()

    var narratives: [StoryContentModel]? = []
    var lottieAnimation: StoryContentModel?
    var bgSound: StoryContentModel?

    init(modelContext: ModelContext? = nil) {
        super.init()
        if modelContext != nil {
            self.modelContext = modelContext
        }
    }

    func fetchStoryContents(_ story: StoryModel) {
        narratives = []
        let storyUid = story.uid

        let fetchDescriptor = FetchDescriptor<StoryContentModel>(
            predicate: #Predicate {
                $0.story?.uid == storyUid
            },
            sortBy: [SortDescriptor<StoryContentModel>(\.createdAt)]
        )

        let getStoryContents = (try? modelContext?.fetch(fetchDescriptor) ?? []) ?? []

        for storyContent in getStoryContents {
            if storyContent.contentType == .text {
                narratives?.append(storyContent)
            } else if storyContent.contentType == .audio {
                bgSound = storyContent
            } else if storyContent.contentType == .lottie {
                lottieAnimation = storyContent
            }
        }
    }
}
