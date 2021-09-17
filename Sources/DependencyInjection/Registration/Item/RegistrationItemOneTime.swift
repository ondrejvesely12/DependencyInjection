//
//  RegistrationItemOneTime.swift
//
//
//  Created by Ondřej Veselý on 17.09.2021.
//

public struct RegistrationItemOneTime<Service, Argument>: RegistrationItemProtocol {
    // MARK: - Properties

    // MARK: Public

    /// The closure that will resolve the service
    public let factory: (Argument) -> Service

    // MARK: Private

    /// Unique name for service
    private let identifier: RegistrationIdentifier

    // MARK: - RegistrationItemProtocol

    public var registrations: [RegistrationProtocol] {
        let registration = Registration<Service, Argument>(.oneTime, factory)
        return [registration]
    }

    // MARK: - Initialization

    public init(name: String, factory: @escaping (Argument) -> Service) {
        self.factory = factory
        identifier = .name(name)
    }

    public init(factory: @escaping (Argument) -> Service) {
        self.factory = factory
        identifier = .objectIdentifier(ObjectIdentifier(Service.self))
    }
}
