//
//  DependencyRegistration.swift
//
//
//  Created by Ondřej Veselý on 12.09.2021.
//

//public struct DependencyRegistration {
 
public struct DependencyRegistration<Service, Argument> {
    // MARK: - Properties

    /// Unique name for service
    public let identifier: RegistrationIdentifier

    /// The closure that will resolve the service
    let factory: (Argument) -> Service

    /// The lifecycle of the current service
    public let lifeCycle: RegistrationLifeCycle
    
    /// Instance
    public var instance: Any?
    
    let argumentType: Argument.Type

    // MARK: - Initialization

    public init(name: String, lifeCycle: RegistrationLifeCycle = .oneTime, _ factory: @escaping (Argument) -> Service) {
        self.identifier = .name(name)
        self.lifeCycle = lifeCycle
        self.factory = factory
        self.argumentType = Argument.self
    }

    public init(_ lifeCycle: RegistrationLifeCycle , _ factory: @escaping (Argument) -> Service ) {
        self.identifier = .objectIdentifier(ObjectIdentifier(Service.self))
        self.lifeCycle = lifeCycle
        self.factory = factory
        self.argumentType = Argument.self
    }
}
