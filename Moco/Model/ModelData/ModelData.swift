//
//  ModelData.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 04/11/23.
//

import Foundation

protocol StoryProtocol {
    var episodes: [EpisodeModel] { get }
    var slug: String { get }
}

enum ModelData {
    static let stories = [Story1()]
    static let dataToBePopulated: [String: [StoryThemeModel]] = [
        "storyThemeModel": [
            // Story theme-1
            StoryThemeModel(
                pictureName: "Story/Cover/Story1",
                episodes: stories[0].episodes,
                slug: stories[0].slug
            )
        ]
    ]
}
