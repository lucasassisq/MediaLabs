// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable function_parameter_count identifier_name line_length type_body_length
public enum AppStrings {
  /// Cancel
  public static let cancel = AppStrings.tr("Localizable", "cancel")
  /// Please, choose your user to go forward!
  public static let chooseUserTitle = AppStrings.tr("Localizable", "chooseUserTitle")
  /// Feed
  public static let feedTitle = AppStrings.tr("Localizable", "feedTitle")
  /// Something wrong happened.
  public static let genericErrorMessage = AppStrings.tr("Localizable", "genericErrorMessage")
  /// Say my name. We haven't any post yet.
  public static let noPostsYet = AppStrings.tr("Localizable", "noPostsYet")
  /// Posterr
  public static let posterr = AppStrings.tr("Localizable", "posterr")
  /// Maybe will be better caul Saul!
  public static let posterrIt = AppStrings.tr("Localizable", "posterrIt")
  /// Profile
  public static let profileTitle = AppStrings.tr("Localizable", "profileTitle")
  /// 777
  public static let totalCharacters = AppStrings.tr("Localizable", "totalCharacters")
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
