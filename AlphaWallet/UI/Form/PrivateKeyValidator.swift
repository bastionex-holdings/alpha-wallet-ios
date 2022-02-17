// Copyright SIX DAY LLC. All rights reserved.

import Foundation

struct ValidationError: Error {
    let msg: String
}

struct PrivateKeyValidator {
    private let validationError: ValidationError
    private static let regex = try? NSRegularExpression(pattern: "^[0-9a-fA-F]{64}$")

    init(msg: String = R.string.localizable.importWalletImportInvalidPrivateKey()) {
        validationError = ValidationError(msg: msg)
    }

    func isValid(value: String) -> ValidationError? {
        //allows for private key import to have 0x or not
        let drop0xKey = value.drop0x
        guard let regex = PrivateKeyValidator.regex else { return nil }
        let range = NSRange(location: 0, length: drop0xKey.utf16.count)
        let result = regex.matches(in: drop0xKey, range: range)
        let matched = !result.isEmpty

        return matched ? nil : validationError
    }
}
