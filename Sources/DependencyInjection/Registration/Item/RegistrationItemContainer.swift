//
//  RegistrationItemContainer.swift
//
//
//  Created by Ondřej Veselý on 17.09.2021.
//

public struct RegistrationItemContainer: RegistrationItemProtocol {
    // MARK: - Properties

    /// Nesting Container that will resolve the service
    public let container: Container

    // MARK: - RegistrationItemProtocol

    public var registrations: [RegistrationProtocol] {
        container.allRegistrations()
    }

    // MARK: - Initialization

    public init(_ container: Container) {
        self.container = container
    }
}
