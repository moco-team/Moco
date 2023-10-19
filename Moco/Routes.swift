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
    case story(String?)
    case storyAdmin(String?)
    case storyThemeAdmin
    case settings
}

// MARK: - Route view definition, set them here

/// Struct that stores all mappings of Views and Routes from Route Enum
struct Routes: View {
    let route: Route

    var body: some View {
        switch route {
        case .home:
            HomeView()
        case let .story(text):
            StoryView(title: text)
        case .storyAdmin:
            StoryAdminView()
        case .storyThemeAdmin:
            StoryThemeAdminView()
        case .settings:
            SettingsView()
        }
    }
}

// MARK: - Route View Model

/// Route view model, should not change if not necessary
@Observable
class RouteViewModel {
    var navPath = NavigationPath()

    // MARK: - Append route to navigation path

    /// Append AKA go to next route
    func append(_ route: Route) {
        navPath.append(route)
    }

    // MARK: - Pop route from navigation path

    /// Pop AKA return to previous view in the navigation stack
    func pop() {
        guard !navPath.isEmpty else {
            print("navPath is empty")
            return
        }
        navPath.removeLast()
    }

    // MARK: - Pop multiple routes

    /// Pop multiple times AKA return to previous view multiple times in the navigation stack
    func pop(_ count: Int) {
        guard navPath.count >= count else {
            print("count must not be greater than navPath.count")
            return
        }
        navPath.removeLast(count)
    }

    // MARK: - Pop to root

    /// Back to root view
    func popToRoot() {
        navPath.removeLast(navPath.count)
    }

    // MARK: - Append multiple routes

    /// Append multiple routes to navigation stack
    func append(_ routes: Route...) {
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
