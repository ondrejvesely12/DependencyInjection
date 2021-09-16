//
//  DependencyContainer+DependencyBuilder.swift
//
//  Created by Ondřej Veselý on 12.09.2021.
//

public extension DependencyContainer {
    convenience init(@DependencyBuilder _ registration: () -> DependencyRegistrationProtocol) {
        self.init(registrations: [registration()])
    }

    convenience init(@DependencyBuilder _ registrations: () -> [DependencyRegistrationProtocol]) {
        self.init(registrations: registrations())
    }
}
