//
//  DependencyContainer.swift
//
//  Created by Ondřej Veselý on 12.09.2021.
//

public final class Container: ContainerProtocol {
    // MARK: - Properties

    // MARK: Private

    private var registrations = [RegistrationIdentifier: RegistrationProtocol]()

    // MARK: - Initialization

    public init() {
        registrations = [:]
    }

    public init(registrations: [RegistrationProtocol]) {
        self.registrations = registrations.reduce(into: [:]) { result, dependencyRegistration in
            result[dependencyRegistration.identifier] = dependencyRegistration
        }
    }

    // MARK: - Registrations

    internal func allRegistrations() -> [RegistrationProtocol] {
        Array(registrations.values)
    }

    // MARK: Register

    /// Adds a registration for the specified service with the factory closure to specify how the service is
    /// resolved with dependencies.
    ///
    /// - Parameters:
    ///   - dependencyRegistration: The service type to register.
    public func register(_ dependencyRegistration: RegistrationProtocol) {
        registrations[dependencyRegistration.identifier] = dependencyRegistration
    }

    // MARK: Remove

    /// Removes registration by the identifier
    public func remove(registrationIdentifier: RegistrationIdentifier) {
        assert(registrations.keys.contains(registrationIdentifier))
        registrations.removeValue(forKey: registrationIdentifier)
    }

    /// Removes all registrations in the container.
    public func removeAll() {
        registrations.removeAll()
    }

    // MARK: Resolve Optional

    /// Retrieves the instance with the specified service type.
    ///
    ///
    /// - Parameters:
    ///   - registrationIdentifier:        The registration identifier.
    ///
    /// - Returns: The resolved service type instance, or nil if no registration for the service type
    ///            is found in the `Container`.
    public func resolveOptional<Service, Argument>(registrationIdentifier: RegistrationIdentifier, argument: Argument) -> Service? {
        guard var dependencyRegistration = registrations[registrationIdentifier] else {
            return nil
        }
        switch dependencyRegistration.lifeCycle {
        case .oneTime:
            return privateResolveOptional(registrationIdentifier: registrationIdentifier, argument: argument)
        case .shared:
            guard let sharedInstance = dependencyRegistration.instance as? Service else {
                let instance: Service? = privateResolveOptional(registrationIdentifier: registrationIdentifier, argument: argument)
                dependencyRegistration.instance = instance
                registrations[dependencyRegistration.identifier] = dependencyRegistration
                return instance
            }
            return sharedInstance
        }
    }

    // MARK: Private Resolve

    private func privateResolveOptional<Service, Argument>(registrationIdentifier: RegistrationIdentifier, argument: Argument) -> Service? {
        guard let dependencyRegistration = registrations[registrationIdentifier] else {
            return nil
        }
        let factory: (Argument) -> Service = dependencyRegistration.getFactory()
        let instance = factory(argument)
        return instance
    }
}
