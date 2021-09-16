//
//  Injected.swift
//
//  Created by Ondřej Veselý on 12.09.2021.
//

@propertyWrapper public struct Injected<Service> {
    // MARK: - Properties

    // MARK: Public

    public let wrappedValue: Service

    // MARK: - Initialization

    public init(container: ContainerProtocol) {
        wrappedValue = container.resolve(argument: ())
    }

    public init(name: String, container: ContainerProtocol) {
        wrappedValue = container.resolve(registrationIdentifier: .name(name), argument: ())
    }
}
