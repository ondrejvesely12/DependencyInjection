//
//  DependencyBuilder.swift
//  
//
//  Created by Ondřej Veselý on 12.09.2021.
//

@resultBuilder struct DependencyBuilder {
    static func buildBlock(_ services: DependencyRegistrationProtocol...) -> [DependencyRegistrationProtocol] { services }
    static func buildBlock(_ service: DependencyRegistrationProtocol) -> DependencyRegistrationProtocol { service }
}
