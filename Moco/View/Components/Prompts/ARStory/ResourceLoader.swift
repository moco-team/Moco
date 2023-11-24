//
//  ResourceLoader.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 25/10/23.
//

import Combine
import Foundation
import RealityKit

class ResourceLoader {
    typealias LoadCompletion = (Result<EnvironmentEntity, Error>) -> Void

    private var loadCancellable: AnyCancellable?
    private var environmentEntity: EnvironmentEntity?

    func loadResources(completion: @escaping LoadCompletion) -> AnyCancellable? {
        guard let environmentEntity else {
            loadCancellable = EnvironmentEntity.loadAsync.sink { result in
                if case let .failure(error) = result {
                    print("Failed to load EnvironmentEntity: \(error)")
                    completion(.failure(error))
                }
            } receiveValue: { [weak self] environmentEntity in
                guard let self else {
                    return
                }
                self.environmentEntity = environmentEntity
                completion(.success(environmentEntity))
            }
            return loadCancellable
        }
        completion(.success(environmentEntity))
        return loadCancellable
    }

    func createEnvironment() throws -> Entity {
        guard let environment = environmentEntity?.model else {
            throw ResourceLoaderError.resourceNotLoaded
        }
        return environment.clone(recursive: true)
    }
}

enum ResourceLoaderError: Error {
    case resourceNotLoaded
}
