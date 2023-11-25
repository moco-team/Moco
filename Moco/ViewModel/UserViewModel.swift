//
//  UserViewModel.swift
//  Moco
//
//  Created by Nur Azizah on 24/11/23.
//

import Foundation
import SwiftData

@Observable class UserViewModel: BaseViewModel {
    static var shared = UserViewModel()

    var users: [UserModel]?
    var userLogin: UserModel?

    init(modelContext: ModelContext? = nil) {
        super.init()
        if modelContext != nil {
            self.modelContext = modelContext
        }
    }

    func fetchUsers() {
        let fetchDescriptor = FetchDescriptor<UserModel>(
            sortBy: [SortDescriptor<UserModel>(\.createdAt)]
        )

        users = (try? modelContext?.fetch(fetchDescriptor) ?? []) ?? []
    }

    func addUser(userData: UserModel) {
        modelContext?.insert(userData)
        try? modelContext?.save()

        fetchUsers()
    }

    func setUserLogin(user: UserModel) {
        userLogin = user
    }

    func addingAvailableStoryTheme() {
        if let userLogin = userLogin {
            userLogin.availableStoryThemeSum += 1
            try? modelContext?.save()
        }
    }

    func addingAvailableEpisode() {
        if let userLogin = userLogin {
            userLogin.availableEpisodeSum += 1
            try? modelContext?.save()
        }
    }

    func deleteAllUsers() {
        fetchUsers()

        if let users = users {
            for user in users {
                modelContext?.delete(user)
                try? modelContext?.save()
            }
        }
    }
}
