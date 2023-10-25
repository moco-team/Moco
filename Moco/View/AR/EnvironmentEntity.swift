//
//  EnvironmentEntity.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 25/10/23.
//

import Combine
import Foundation
import RealityKit

final class EnvironmentEntity: Entity {
    var model: Entity?

    static var loadAsync: AnyPublisher<EnvironmentEntity, Error> {
        return Entity.loadAsync(named: "environment")
            .map { loadedEnvironment -> EnvironmentEntity in
                let environment = EnvironmentEntity()
                loadedEnvironment.name = "Cup"
                environment.model = loadedEnvironment
                return environment
            }
            .eraseToAnyPublisher()
    }
}
