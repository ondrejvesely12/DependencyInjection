//
//  DependencyRegistrationProtocol.swift
//
//  Created by Ondřej Veselý on 12.09.2021.
//

public protocol RegistrationProtocol {
    /// Unique name for service
    var identifier: RegistrationIdentifier { get }

    /// The lifecycle of the current service
    var lifeCycle: Scope { get }

    /// Instance
    var instance: Any? { get set }

    /// get the closure that will resolve the service
    func getFactory<Service, Argument>() -> ((Argument) -> Service)
}
