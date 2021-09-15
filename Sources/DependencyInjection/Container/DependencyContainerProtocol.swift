//
//  DependencyContainerProtocol.swift
//
//  Created by Ondřej Veselý on 12.09.2021.
//

public protocol DependencyContainerProtocol {
    // MARK: Register

    /// Adds a registration for the specified service
    ///
    /// - Parameters:
    ///   - dependencyRegistration: The service to register.
    func register(_ dependencyRegistration: DependencyRegistrationProtocol)

    // MARK: Remove

    /// Removes registration by the identifier
    func remove(registrationIdentifier: RegistrationIdentifier)

    /// Removes all registrations in the container.
    func removeAll()

    // MARK: Resolve

    /// Retrieves the instance with the specified service type.
    ///
    ///
    /// - Parameters:
    ///   - registrationIdentifier:        The registration identifier.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type
    ///            is found in the `Container`.
    func resolveOptional<Service, Argument>(registrationIdentifier: RegistrationIdentifier, argument: Argument) -> Service?
}
