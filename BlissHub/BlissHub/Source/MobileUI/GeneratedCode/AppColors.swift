// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(OSX)
  import AppKit
  internal enum AppColors { }
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit
  internal enum AppColors { }
#endif

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Colors

// swiftlint:disable identifier_name line_length type_body_length
internal extension AppColors {
  /// 0x000000ff (r: 0, g: 0, b: 0, a: 255)
  internal static let black = #colorLiteral(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
  /// 0x0000ffff (r: 0, g: 0, b: 255, a: 255)
  internal static let blue = #colorLiteral(red: 0.0, green: 0.0, blue: 1.0, alpha: 1.0)
  /// 0x00ff00ff (r: 0, g: 255, b: 0, a: 255)
  internal static let green = #colorLiteral(red: 0.0, green: 1.0, blue: 0.0, alpha: 1.0)
  /// 0x4d4d4dff (r: 77, g: 77, b: 77, a: 255)
  internal static let grey4D4D4D = #colorLiteral(red: 0.3019608, green: 0.3019608, blue: 0.3019608, alpha: 1.0)
  /// 0xff0000ff (r: 255, g: 0, b: 0, a: 255)
  internal static let red = #colorLiteral(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
  /// 0xffffffff (r: 255, g: 255, b: 255, a: 255)
  internal static let white = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
}
// swiftlint:enable identifier_name line_length type_body_length
