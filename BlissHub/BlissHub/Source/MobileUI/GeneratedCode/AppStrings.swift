// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum AppStrings {
  /// apple/
  internal static let appleRepoFullnamePrefix = AppStrings.tr("Localizable", "appleRepoFullnamePrefix")
  /// /users/apple/repos
  internal static let githubAPIURLAppleRepos = AppStrings.tr("Localizable", "githubAPIURLAppleRepos")
  /// page
  internal static let githubAPIURLAppleReposArgPage = AppStrings.tr("Localizable", "githubAPIURLAppleReposArgPage")
  /// per_page
  internal static let githubAPIURLAppleReposArgPerPage = AppStrings.tr("Localizable", "githubAPIURLAppleReposArgPerPage")
  /// /users/
  internal static let githubAPIURLAvatars = AppStrings.tr("Localizable", "githubAPIURLAvatars")
  /// http://api.github.com
  internal static let githubAPIURLBase = AppStrings.tr("Localizable", "githubAPIURLBase")
  /// application/json
  internal static let githubAPIURLContentTypeAppJSON = AppStrings.tr("Localizable", "githubAPIURLContentTypeAppJSON")
  /// Content-type
  internal static let githubAPIURLContentTypeKey = AppStrings.tr("Localizable", "githubAPIURLContentTypeKey")
  /// /emojis
  internal static let githubAPIURLEmojis = AppStrings.tr("Localizable", "githubAPIURLEmojis")
  /// Half measures are as bad as nothing at all.
  internal static let githubAPIURLSampleData = AppStrings.tr("Localizable", "githubAPIURLSampleData")
  /// Unable to initialize presenter for AppleRepos module
  internal static let presenterInitErrorAppleRepos = AppStrings.tr("Localizable", "presenterInitErrorAppleRepos")
  /// Unable to initialize presenter for Avatars module
  internal static let presenterInitErrorAvatars = AppStrings.tr("Localizable", "presenterInitErrorAvatars")
  /// Unable to initialize presenter for Emojis module
  internal static let presenterInitErrorEmojis = AppStrings.tr("Localizable", "presenterInitErrorEmojis")
  /// Unable to create Realm database instance
  internal static let realmInitError = AppStrings.tr("Localizable", "realmInitError")
  /// username
  internal static let username = AppStrings.tr("Localizable", "username")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension AppStrings {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    // swiftlint:disable:next nslocalizedstring_key
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
