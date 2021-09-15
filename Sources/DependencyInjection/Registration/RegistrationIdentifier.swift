//
//  RegistrationIdentifier.swift
//
//  Created by Ondřej Veselý on 12.09.2021.
//

/// that uniquely identifies the given registration
public enum RegistrationIdentifier: Hashable {
    /// id of registration by string
    case name(String)

    /// id of registration by object identifier
    case objectIdentifier(ObjectIdentifier)
}
