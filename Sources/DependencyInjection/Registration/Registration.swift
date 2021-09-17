//
//  DependencyRegistration.swift
//
//  Created by Ondřej Veselý on 12.09.2021.
//

public struct Registration<Service, Argument> {
    // MARK: - Properties

    /// Unique name for service
    public let identifier: RegistrationIdentifier

    /// The closure that will resolve the service
    let factory: (Argument) -> Service

    /// The lifecycle of the current service
    public let lifeCycle: Scope

    /// Instance
    public var instance: Any?

    let argumentType: Argument.Type

    // MARK: - Initialization

    public init(name: String, lifeCycle: Scope = .oneTime, _ factory: @escaping (Argument) -> Service) {
        identifier = .name(name)
        self.lifeCycle = lifeCycle
        self.factory = factory
        argumentType = Argument.self
    }

    public init(_ lifeCycle: Scope, _ factory: @escaping (Argument) -> Service) {
        identifier = .objectIdentifier(ObjectIdentifier(Service.self))
        self.lifeCycle = lifeCycle
        self.factory = factory
        argumentType = Argument.self
    }
}
