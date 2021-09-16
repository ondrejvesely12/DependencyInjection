//
//  LazyInjectedWithArgument.swift
//
//  Created by Ondřej Veselý on 15.09.2021.
//

@propertyWrapper public struct LazyInjectedWithArgument<Service, Argument> {
    // MARK: - Properties

    // MARK: Public

    public var wrappedValue: Service {
        mutating get {
            if let value = value {
                return value
            } else {
                let newValue: Service = container.resolve(registrationIdentifier: registrationIdentifier, argument: argument)
                value = newValue
                return newValue
            }
        }
    }

    // MARK: Private

    private var value: Service?
    private var container: DependencyContainerProtocol
    private var name: String?
    private var argument: Argument

    private var registrationIdentifier: RegistrationIdentifier {
        guard let name = name else {
            return .objectIdentifier(ObjectIdentifier(Service.self))
        }
        return .name(name)
    }

    // MARK: - Initialization

    public init(name: String, argument: Argument, container: DependencyContainerProtocol) {
        self.container = container
        self.argument = argument
        self.name = name
    }

    public init(argument: Argument, container: DependencyContainerProtocol) {
        self.container = container
        self.argument = argument
    }
}
