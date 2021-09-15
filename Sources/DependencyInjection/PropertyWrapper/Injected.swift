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

    public init(_ container: DependencyContainerProtocol) {
        wrappedValue = container.resolve(argument: ())
    }

    public init(_ container: DependencyContainerProtocol, name: String) {
        wrappedValue = container.resolve(registrationIdentifier: .name(name), argument: ())
    }
}
