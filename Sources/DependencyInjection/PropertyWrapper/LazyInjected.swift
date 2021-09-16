//
//  LazyInjected.swift
//
//  Created by Ondřej Veselý on 15.09.2021.
//

@propertyWrapper public struct LazyInjected<Service> {
    // MARK: - Properties

    // MARK: Public

    public var wrappedValue: Service {
        mutating get {
            if let value = value {
                return value
            } else {
                let newValue: Service = container.resolve(registrationIdentifier: registrationIdentifier)
                value = newValue
                return newValue
            }
        }
    }

    // MARK: Private

    private var value: Service?
    private var container: DependencyContainerProtocol
    private var name: String?

    private var registrationIdentifier: RegistrationIdentifier {
        guard let name = name else {
            return .objectIdentifier(ObjectIdentifier(Service.self))
        }
        return .name(name)
    }

    // MARK: - Initialization

    public init(name: String? = nil, container: DependencyContainerProtocol) {
        self.container = container
        self.name = name
    }
}
