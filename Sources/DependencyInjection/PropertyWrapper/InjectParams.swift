//
//  InjectParams.swift
//  
//
//  Created by Ondřej Veselý on 12.09.2021.
//

struct InjectParam<T, Argument> {
    // MARK: - Properties

    // MARK: Public

    let wrappedValue: T

    // MARK: - Initialization

    init(_ container: DependencyContainerProtocol, argument: Argument) {
        wrappedValue = container.resolve(argument: argument)
    }

    init(_ container: DependencyContainerProtocol, name: String, argument: Argument) {
        wrappedValue = container.resolve(registrationIdentifier: .name(name), argument: argument)
    }
}
