//
//  DependencyBuilder.swift
//
//  Created by Ondřej Veselý on 12.09.2021.
//

@resultBuilder public enum DependencyBuilder {
    public static func buildBlock(_ services: DependencyRegistrationProtocol...) -> [DependencyRegistrationProtocol] { services }
    public static func buildBlock(_ service: DependencyRegistrationProtocol) -> DependencyRegistrationProtocol { service }
}
