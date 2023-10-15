//
//  Routes.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 15/10/23.
//

import SwiftUI

// MARK: - Route Key definition

enum Route: Hashable {
    case home
    case story(String?)
    case settings
}

// MARK: - Route view definition, set them here

struct Routes: View {
    let route: Route

    var body: some View {
        switch route {
        case .home:
            HomeView()
        case let .story(text):
            StoryView(title: text)
        case .settings:
            SettingsView()
        }
    }
}

// MARK: - Route View Model

@Observable
class RouteViewModel {
    var navPath = NavigationPath()

    // MARK: - Append route to navigation path

    func append(_ route: Route) {
        navPath.append(route)
    }

    // MARK: - Pop route from navigation path

    func pop() {
        guard !navPath.isEmpty else {
            print("navPath is empty")
            return
        }
        navPath.removeLast()
    }

    // MARK: - Pop multiple routes

    func pop(_ count: Int) {
        guard navPath.count >= count else {
            print("count must not be greater than navPath.count")
            return
        }
        navPath.removeLast(count)
    }

    // MARK: - Pop to root

    func popToRoot() {
        navPath.removeLast(navPath.count)
    }

    // MARK: - Append multiple routes

    func append(_ routes: Route...) {
        for route in routes {
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
