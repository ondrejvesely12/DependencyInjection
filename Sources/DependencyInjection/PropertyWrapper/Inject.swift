//
//  Inject.swift
//  
//
//  Created by Ondřej Veselý on 12.09.2021.
//

@propertyWrapper struct Inject<T> {
    // MARK: - Properties

    // MARK: Public

    let wrappedValue: T

    // MARK: - Initialization

    init(_ container: DependencyContainerProtocol) {
        wrappedValue = container.resolve(argument: Void())
    }

    init(_ container: DependencyContainerProtocol, name: String) {
        wrappedValue = container.resolve(registrationIdentifier: .name(name), argument: Void())
    }
}


