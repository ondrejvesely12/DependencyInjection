//
//  RegistrationBuilder.swift
//
//  Created by Ondřej Veselý on 12.09.2021.
//

@resultBuilder
enum RegistrationBuilder {
    public static func buildBlock(_ inputs: RegistrationItemProtocol...) -> [RegistrationItemProtocol] {
        inputs
    }
}
