//
//  MocoApp.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 11/10/23.
//

import SwiftData
import SwiftUI

@main
struct MocoApp: App {
    // MARK: - Bindables

    @Bindable private var routeViewModel = RouteViewModel()

    // MARK: - States

    @State private var audioViewModel = AudioViewModel()
    @State private var timerViewModel = TimerViewModel()
    @State private var itemViewModel = ItemViewModel()
    @State private var storyThemeViewModel = StoryThemeViewModel()
    @State private var episodeViewModel = EpisodeViewModel()

    // MARK: - State Objects

    @StateObject private var speechViewModel = SpeechRecognizerViewModel.shared
    @StateObject private var objectDetectionViewModel = ObjectDetectionViewModel.shared
    @StateObject private var arViewModel = ARViewModel()
    @StateObject private var motionViewModel = MotionViewModel()

    private static let sharedModelContainer: ModelContainer = ModelGenerator.generator(false)
    static let modelContext = ModelContext(sharedModelContainer)

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $routeViewModel.navPath) {
                ContentViewContainer()
            }.environment(\.navigate, routeViewModel)
                .environment(\.font, Font.custom("CherryBomb-Regular", size: 24, relativeTo: .body))
                .environment(\.itemViewModel, itemViewModel)
                .environment(\.storyThemeViewModel, storyThemeViewModel)
                .environment(\.episodeViewModel, episodeViewModel)
                .environment(\.audioViewModel, audioViewModel)
                .environment(\.timerViewModel, timerViewModel)
                .environmentObject(speechViewModel)
                .environmentObject(objectDetectionViewModel)
                .environmentObject(arViewModel)
                .environmentObject(motionViewModel)
        }
    }
}
