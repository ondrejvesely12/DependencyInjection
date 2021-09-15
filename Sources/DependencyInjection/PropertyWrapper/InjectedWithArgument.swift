//
//  InjectedWithArgument.swift
//
//  Created by Ondřej Veselý on 12.09.2021.
//

public struct InjectedWithArgument<Service, Argument> {
    // MARK: - Properties

    // MARK: Public

    public let wrappedValue: Service

    // MARK: - Initialization

    public init(_ container: DependencyContainerProtocol, argument: Argument) {
        wrappedValue = container.resolve(argument: argument)
    }

    public init(_ container: DependencyContainerProtocol, name: String, argument: Argument) {
        wrappedValue = container.resolve(registrationIdentifier: .name(name), argument: argument)
    }
}
