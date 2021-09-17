//
//  Container+RegistrationBuilder.swift
//
//  Created by Ondřej Veselý on 12.09.2021.
//

public extension Container {
    convenience init(@RegistrationBuilder _ registrations: () -> [RegistrationItemProtocol]) {
        let registrations = registrations().reduce(into: []) { result, registrationItemProtocol in
            result += registrationItemProtocol.registrations
        }
        self.init(registrations: registrations)
    }
}
