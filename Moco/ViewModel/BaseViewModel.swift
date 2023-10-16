//
//  BaseViewModel.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 14/10/23.
//

import Foundation
import SwiftData

protocol BaseViewModelProtocol {
    var modelContext: ModelContext? { get set }
}

@Observable class BaseViewModel {
    var modelContext: ModelContext? = MocoApp.modelContext
}
