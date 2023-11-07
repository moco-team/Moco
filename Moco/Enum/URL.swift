//
//  URL.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 27/10/23.
//

import Foundation

enum URLType {
    case name(String)
    case url(URL)

    var url: URL? {
        switch self {
        case let .name(name):
            return Bundle.main.url(forResource: name, withExtension: "gif")
        case let .url(remoteURL):
            return remoteURL
        }
    }
}
