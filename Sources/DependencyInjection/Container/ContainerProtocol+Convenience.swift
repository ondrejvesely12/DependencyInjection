//
//  ContainerProtocol+Convenience.swift
//
//  Created by Ondřej Veselý on 12.09.2021.
//

public extension ContainerProtocol {
    // MARK: - Register

    func register<Service, Argument>(name: String, lifeCycle: RegistrationLifeCycle, _ factory: @escaping (_ argument: Argument) -> Service) {
        register(Registration(name: name, lifeCycle: lifeCycle, factory))
    }

    func register<Service, Argument>(lifeCycle: RegistrationLifeCycle, _ factory: @escaping (_ argument: Argument) -> Service) {
        register(Registration(lifeCycle, factory))
    }

    // MARK: - Resolve

    // MARK: Optional

    func resolveOptional<Service>(registrationIdentifier: RegistrationIdentifier) -> Service? {
        resolveOptional(registrationIdentifier: registrationIdentifier, argument: ())
    }

    func resolveOptional<Service>(name: String) -> Service? {
        resolveOptional(registrationIdentifier: .name(name), argument: ())
    }

    func resolveOptional<Service, Argument>(name: String, argument: Argument) -> Service? {
        resolveOptional(registrationIdentifier: .name(name), argument: argument)
    }

    func resolveOptional<Service, Argument>(argument: Argument) -> Service? {
        let registrationIdentifier = RegistrationIdentifier.objectIdentifier(ObjectIdentifier(Service.self))
        return resolveOptional(registrationIdentifier: registrationIdentifier, argument: argument)
    }

    func resolveOptional<Service>() -> Service? {
        let registrationIdentifier = RegistrationIdentifier.objectIdentifier(ObjectIdentifier(Service.self))
        return resolveOptional(registrationIdentifier: registrationIdentifier, argument: ())
    }

    // MARK: Non Optional

    func resolve<Service, Argument>(argument: Argument) -> Service {
        guard let service: Service = resolveOptional(argument: argument) else {
            fatalError("No dependency found for \"\(Service.self)\" must register a dependency before resolve.")
        }
        return service
    }

    func resolve<Service, Argument>(name: String, argument: Argument) -> Service {
        guard let service: Service = resolveOptional(name: name, argument: argument) else {
            fatalError("No named \"\(name)\" dependency found for \"\(Service.self)\" must register a dependency before resolve.")
        }
        return service
    }

    func resolve<Service>() -> Service {
        guard let service: Service = resolveOptional() else {
            fatalError("No dependency found for \"\(Service.self)\" must register a dependency before resolve.")
        }
        return service
    }

    func resolve<Service>(name: String) -> Service {
        guard let service: Service = resolveOptional(name: name) else {
            fatalError("No named \"\(name)\" dependency found for \"\(Service.self)\" must register a dependency before resolve.")
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
