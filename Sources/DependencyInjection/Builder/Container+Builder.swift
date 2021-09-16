//
//  Container+RegistrationBuilder.swift
//
//  Created by Ondřej Veselý on 12.09.2021.
//

public extension Container {
    convenience init(@RegistrationBuilder _ registration: () -> RegistrationProtocol) {
        self.init(registrations: [registration()])
    }

    convenience init(@RegistrationBuilder _ registrations: () -> [RegistrationProtocol]) {
        self.init(registrations: registrations())
    }
}
