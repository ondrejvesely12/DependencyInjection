//
//  DependencyContainer+DependencyBuilder.swift
//
//  Created by Ondřej Veselý on 12.09.2021.
//

extension DependencyContainer {
    convenience init(@DependencyBuilder _ service: () -> DependencyRegistrationProtocol) {
        self.init()
        register(service())
    }

    convenience init(@DependencyBuilder _ services: () -> [DependencyRegistrationProtocol]) {
        self.init()
        services().forEach { register($0) }
    }
}
