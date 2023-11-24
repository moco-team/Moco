//
//  Process.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 11/11/23.
//

import Foundation

struct Process {
    static var isPreview: Bool {
        ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    }
}
