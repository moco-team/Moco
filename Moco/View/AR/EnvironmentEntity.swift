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
                loadedEnvironment.name = "environment"
                loadedEnvironment.transform.translation = .init(0.2, 0, 0)
                let environment = EnvironmentEntity()
                environment.model = loadedEnvironment
                return environment
            }
            .eraseToAnyPublisher()
    }
}
