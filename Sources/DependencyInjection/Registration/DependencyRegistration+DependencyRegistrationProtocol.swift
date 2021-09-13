//
//  DependencyRegistration+DependencyRegistrationProtocol.swift
//  
//
//  Created by Ondřej Veselý on 12.09.2021.
//

extension DependencyRegistration: DependencyRegistrationProtocol {
    public func getFactory<Service, Argument>() -> ((Argument) -> Service) {
        let sssss = factory
        print(sssss)
        guard let factory = factory as? (Argument) -> Service else {
            fatalError()
        }
        return factory
    }
}
