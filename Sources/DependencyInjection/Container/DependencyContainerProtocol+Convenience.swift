//
//  DependencyContainerProtocol+Convenience.swift
//  
//
//  Created by Ondřej Veselý on 12.09.2021.
//

public extension DependencyContainerProtocol {
    // MARK: - Register

    func register<Service, Argument>(name: String, lifeCycle: RegistrationLifeCycle, _ factory: @escaping (_ argument: Argument) -> Service) {
        register(DependencyRegistration(name: name, lifeCycle: lifeCycle, factory))
    }

    func register<Service, Argument>(lifeCycle: RegistrationLifeCycle,_ factory: @escaping (_ argument: Argument) -> Service) {
        register(DependencyRegistration(lifeCycle, factory))
    }

    // MARK: - Resolve

    // MARK: Optional

    func resolveOptional<Service>(registrationIdentifier: RegistrationIdentifier) -> Service? {
        resolveOptional(registrationIdentifier: registrationIdentifier, argument: Void())
    }

    func resolveOptional<Service, Argument>(argument: Argument) -> Service? {
        let registrationIdentifier = RegistrationIdentifier.objectIdentifier(ObjectIdentifier(Service.self))
        return resolveOptional(registrationIdentifier: registrationIdentifier, argument: argument)
    }

    func resolveOptional<Service>() -> Service? {
        let registrationIdentifier = RegistrationIdentifier.objectIdentifier(ObjectIdentifier(Service.self))
        return resolveOptional(registrationIdentifier: registrationIdentifier, argument: Void())
    }

    // MARK: Non Optional

    func resolve<Service, Argument>(argument: Argument) -> Service {
        guard let service: Service = resolveOptional(argument: argument) else {
            fatalError("No dependency found for \"\(Service.self)\" must register a dependency before resolve.")
        }
        return service
    }

    func resolve<Service>() -> Service {
        guard let service: Service = resolveOptional() else {
            fatalError("No dependency found for \"\(Service.self)\" must register a dependency before resolve.")
        }
        return service
    }

    func resolve<Service, Argument>(registrationIdentifier: RegistrationIdentifier, argument: Argument) -> Service {
        guard let service: Service = resolveOptional(registrationIdentifier: registrationIdentifier, argument: argument) else {
            fatalError("No dependency found for \"\(Service.self)\" must register a dependency before resolve.")
        }
        return service
    }

    func resolve<Service>(registrationIdentifier: RegistrationIdentifier) -> Service {
        guard let service: Service = resolveOptional(registrationIdentifier: registrationIdentifier) else {
            fatalError("No dependency found for \"\(Service.self)\" must register a dependency before resolve.")
        }
        return service
    }
}
