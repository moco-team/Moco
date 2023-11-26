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
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    // MARK: - Bindables

    @Bindable private var routeViewModel = RouteViewModel.shared

    // MARK: - States

    @State private var audioViewModel = AudioViewModel.shared
    @State private var timerViewModel = TimerViewModel.shared
    @State private var storyThemeViewModel = StoryThemeViewModel.shared
    @State private var episodeViewModel = EpisodeViewModel.shared
    @State private var storyViewModel = StoryViewModel.shared
    @State private var storyContentViewModel = StoryContentViewModel.shared
    @State private var promptViewModel = PromptViewModel.shared
    @State private var hintViewModel = HintViewModel.shared
    @State private var userViewModel = UserViewModel.shared
    @State private var settingsViewModel = SettingsViewModel.shared
    @State private var mazePromptViewModel = MazePromptViewModel.shared
    @State private var gameKitViewModel = GameKitViewModel.shared

    // MARK: - State Objects

    @StateObject private var objectDetectionViewModel = ObjectDetectionViewModel.shared
    @StateObject private var arViewModel = ARViewModel()
    @StateObject private var motionViewModel = MotionViewModel()
    @StateObject private var orientationInfo = OrientationInfo.shared

    private static let sharedModelContainer: ModelContainer = ModelGenerator.generator(false)
    static let modelContext = ModelContext(sharedModelContainer)

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $routeViewModel.navPath) {
                ContentViewContainer()
            }.environment(\.navigate, routeViewModel)
                .environment(\.font, Font.custom("CherryBomb-Regular", size: 24, relativeTo: .body))
                .environment(\.userViewModel, userViewModel)
                .environment(\.storyThemeViewModel, storyThemeViewModel)
                .environment(\.episodeViewModel, episodeViewModel)
                .environment(\.storyViewModel, storyViewModel)
                .environment(\.storyContentViewModel, storyContentViewModel)
                .environment(\.promptViewModel, promptViewModel)
                .environment(\.hintViewModel, hintViewModel)
                .environment(\.audioViewModel, audioViewModel)
                .environment(\.timerViewModel, timerViewModel)
                .environment(\.mazePromptViewModel, mazePromptViewModel)
                .environment(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=Key Path@*/\.sizeCategory/*@END_MENU_TOKEN@*/, /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.extraExtraLarge/*@END_MENU_TOKEN@*/)
                .environmentObject(objectDetectionViewModel)
                .environmentObject(arViewModel)
                .environmentObject(motionViewModel)
                .environmentObject(orientationInfo)
        }
    }
}
