//
//  Routes.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 15/10/23.
//

import SwiftUI

// MARK: - Route Key definition

/// Definition of route keys
enum Route: Hashable {
    case home
    case story
//    case storyAdmin(String?)
//    case storyThemeAdmin
    case settings
    case profile
    case achievements
    case arStory
    case episode
}

// MARK: - Route view definition, set them here

/// Struct that stores all mappings of Views and Routes from Route Enum
struct Routes: View {
    let route: Route

    var body: some View {
        switch route {
        case .home:
            HomeView()
        case .story:
            StoryView()
//        case .storyAdmin:
//            StoryAdminView()
//        case .storyThemeAdmin:
//            StoryThemeAdminView()
        case .settings:
            SettingsView()
        case .profile:
            ProfileView()
        case .achievements:
            AchievementsView()
        case .arStory:
            ARStory()
        case .episode:
            EpisodeView()
        }
    }
}

// MARK: - Route View Model

/// Route view model, should not change if not necessary
@Observable
class RouteViewModel {
    var navPath = [Route]() {
        willSet {
            previousRoute = navPath.last
        }
    }

    private(set) var previousRoute: Route?
    var currentRoute: Route? {
        navPath.last
    }

    // MARK: - Append route to navigation path

    /// Append AKA go to next route
    func append(_ route: Route, before: (() -> Void)? = nil) {
        before?()
        navPath.append(route)
    }

    // MARK: - Pop route from navigation path

    /// Pop AKA return to previous view in the navigation stack
    func pop(before: (() -> Void)? = nil) {
        guard !navPath.isEmpty else {
            print("navPath is empty")
            return
        }
        before?()
        navPath.removeLast()
    }

    // MARK: - Pop multiple routes

    /// Pop multiple times AKA return to previous view multiple times in the navigation stack
    func pop(_ count: Int, before: (() -> Void)? = nil) {
        guard navPath.count >= count else {
            print("count must not be greater than navPath.count")
            return
        }
        before?()
        navPath.removeLast(count)
    }

    // MARK: - Pop to root

    /// Back to root view
    func popToRoot(before: (() -> Void)? = nil) {
        before?()
        navPath.removeLast(navPath.count)
    }

    // MARK: - Append multiple routes

    /// Append multiple routes to navigation stack
    func append(_ routes: Route..., before: (() -> Void)? = nil) {
        before?()
        routes.forEach { route in
            navPath.append(route)
        }
    }
}

// MARK: - Environments Definition

struct NavigationEnvironmentKey: EnvironmentKey {
    static var defaultValue: RouteViewModel = .init()
}

struct NavigateToRootEnvironmentKey: EnvironmentKey {
    static var defaultValue: RouteViewModel = .init()
}

extension EnvironmentValues {
    var navigate: RouteViewModel {
        get { self[NavigationEnvironmentKey.self] }
        set { self[NavigationEnvironmentKey.self] = newValue }
    }
}
