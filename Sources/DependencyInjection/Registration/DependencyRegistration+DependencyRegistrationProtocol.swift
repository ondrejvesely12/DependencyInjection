//
//  DependencyRegistration+DependencyRegistrationProtocol.swift
//
//  Created by Ondřej Veselý on 12.09.2021.
//

extension DependencyRegistration: DependencyRegistrationProtocol {
    public func getFactory<Service, Argument>() -> ((Argument) -> Service) {
        guard let factory = factory as? (Argument) -> Service else {
            fatalError("No dependency found for \"\(Service.self)\" \"\(Argument.self)\" must register a dependency before resolve.")
        }
        return factory
    }
}
