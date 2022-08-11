// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable function_parameter_count identifier_name line_length type_body_length
public enum AppStrings {
  /// Something wrong happened.
  public static let genericErrorMessage = AppStrings.tr("Localizable", "genericErrorMessage")
  /// High: 
  public static let highTemp = AppStrings.tr("Localizable", "highTemp")
  /// Low: 
  public static let lowTemp = AppStrings.tr("Localizable", "lowTemp")
  /// Wind: 
  public static let wind = AppStrings.tr("Localizable", "wind")
}
// swiftlint:enable function_parameter_count identifier_name line_length type_body_length

// MARK: - Implementation Details

extension AppStrings {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
