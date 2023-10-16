//
//  BaseViewModel.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 14/10/23.
//

import Foundation
import SwiftData

protocol BaseViewModelProtocol {
    var repository: ItemRepository? { get set }
}

@Observable class BaseViewModel: BaseViewModelProtocol {
    var repository: ItemRepository? = nil
}
