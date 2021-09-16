//
//  RegistrationBuilder.swift
//
//  Created by Ondřej Veselý on 12.09.2021.
//

@resultBuilder public enum RegistrationBuilder {
    public static func buildBlock(_ services: RegistrationProtocol...) -> [RegistrationProtocol] { services }
    public static func buildBlock(_ service: RegistrationProtocol) -> RegistrationProtocol { service }
}
