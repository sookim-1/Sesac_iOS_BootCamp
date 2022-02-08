//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap { Locale(identifier: $0) } ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)

  /// Find first language and bundle for which the table exists
  fileprivate static func localeBundle(tableName: String, preferredLanguages: [String]) -> (Foundation.Locale, Foundation.Bundle)? {
    // Filter preferredLanguages to localizations, use first locale
    var languages = preferredLanguages
      .map { Locale(identifier: $0) }
      .prefix(1)
      .flatMap { locale -> [String] in
        if hostingBundle.localizations.contains(locale.identifier) {
          if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
            return [locale.identifier, language]
          } else {
            return [locale.identifier]
          }
        } else if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
          return [language]
        } else {
          return []
        }
      }

    // If there's no languages, use development language as backstop
    if languages.isEmpty {
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages = [developmentLocalization]
      }
    } else {
      // Insert Base as second item (between locale identifier and languageCode)
      languages.insert("Base", at: 1)

      // Add development language as backstop
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages.append(developmentLocalization)
      }
    }

    // Find first language for which table exists
    // Note: key might not exist in chosen language (in that case, key will be shown)
    for language in languages {
      if let lproj = hostingBundle.url(forResource: language, withExtension: "lproj"),
         let lbundle = Bundle(url: lproj)
      {
        let strings = lbundle.url(forResource: tableName, withExtension: "strings")
        let stringsdict = lbundle.url(forResource: tableName, withExtension: "stringsdict")

        if strings != nil || stringsdict != nil {
          return (Locale(identifier: language), lbundle)
        }
      }
    }

    // If table is available in main bundle, don't look for localized resources
    let strings = hostingBundle.url(forResource: tableName, withExtension: "strings", subdirectory: nil, localization: nil)
    let stringsdict = hostingBundle.url(forResource: tableName, withExtension: "stringsdict", subdirectory: nil, localization: nil)

    if strings != nil || stringsdict != nil {
      return (applicationLocale, hostingBundle)
    }

    // If table is not found for requested languages, key will be shown
    return nil
  }

  /// Load string from Info.plist file
  fileprivate static func infoPlistString(path: [String], key: String) -> String? {
    var dict = hostingBundle.infoDictionary
    for step in path {
      guard let obj = dict?[step] as? [String: Any] else { return nil }
      dict = obj
    }
    return dict?[key] as? String
  }

  static func validate() throws {
    try font.validate()
    try intern.validate()
  }

  #if os(iOS) || os(tvOS)
  /// This `R.storyboard` struct is generated, and contains static references to 1 storyboards.
  struct storyboard {
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    #endif

    fileprivate init() {}
  }
  #endif

  /// This `R.color` struct is generated, and contains static references to 16 colors.
  struct color {
    /// Color `AccentColor`.
    static let accentColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "AccentColor")
    /// Color `black`.
    static let black = Rswift.ColorResource(bundle: R.hostingBundle, name: "black")
    /// Color `error`.
    static let error = Rswift.ColorResource(bundle: R.hostingBundle, name: "error")
    /// Color `focus`.
    static let focus = Rswift.ColorResource(bundle: R.hostingBundle, name: "focus")
    /// Color `gray1`.
    static let gray1 = Rswift.ColorResource(bundle: R.hostingBundle, name: "gray1")
    /// Color `gray2`.
    static let gray2 = Rswift.ColorResource(bundle: R.hostingBundle, name: "gray2")
    /// Color `gray3`.
    static let gray3 = Rswift.ColorResource(bundle: R.hostingBundle, name: "gray3")
    /// Color `gray4`.
    static let gray4 = Rswift.ColorResource(bundle: R.hostingBundle, name: "gray4")
    /// Color `gray5`.
    static let gray5 = Rswift.ColorResource(bundle: R.hostingBundle, name: "gray5")
    /// Color `gray6`.
    static let gray6 = Rswift.ColorResource(bundle: R.hostingBundle, name: "gray6")
    /// Color `gray7`.
    static let gray7 = Rswift.ColorResource(bundle: R.hostingBundle, name: "gray7")
    /// Color `green`.
    static let green = Rswift.ColorResource(bundle: R.hostingBundle, name: "green")
    /// Color `success`.
    static let success = Rswift.ColorResource(bundle: R.hostingBundle, name: "success")
    /// Color `white`.
    static let white = Rswift.ColorResource(bundle: R.hostingBundle, name: "white")
    /// Color `whitegreen`.
    static let whitegreen = Rswift.ColorResource(bundle: R.hostingBundle, name: "whitegreen")
    /// Color `yellowgreen`.
    static let yellowgreen = Rswift.ColorResource(bundle: R.hostingBundle, name: "yellowgreen")

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "AccentColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func accentColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.accentColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "black", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func black(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.black, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "error", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func error(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.error, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "focus", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func focus(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.focus, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "gray1", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func gray1(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.gray1, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "gray2", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func gray2(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.gray2, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "gray3", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func gray3(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.gray3, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "gray4", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func gray4(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.gray4, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "gray5", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func gray5(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.gray5, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "gray6", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func gray6(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.gray6, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "gray7", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func gray7(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.gray7, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "green", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func green(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.green, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "success", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func success(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.success, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "white", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func white(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.white, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "whitegreen", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func whitegreen(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.whitegreen, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "yellowgreen", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func yellowgreen(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.yellowgreen, compatibleWith: traitCollection)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "AccentColor", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func accentColor(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.accentColor.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "black", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func black(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.black.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "error", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func error(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.error.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "focus", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func focus(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.focus.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "gray1", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func gray1(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.gray1.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "gray2", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func gray2(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.gray2.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "gray3", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func gray3(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.gray3.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "gray4", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func gray4(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.gray4.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "gray5", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func gray5(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.gray5.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "gray6", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func gray6(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.gray6.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "gray7", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func gray7(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.gray7.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "green", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func green(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.green.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "success", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func success(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.success.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "white", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func white(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.white.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "whitegreen", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func whitegreen(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.whitegreen.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "yellowgreen", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func yellowgreen(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.yellowgreen.name)
    }
    #endif

    fileprivate init() {}
  }

  /// This `R.entitlements` struct is generated, and contains static references to 1 properties.
  struct entitlements {
    static let apsEnvironment = infoPlistString(path: [], key: "aps-environment") ?? "development"

    fileprivate init() {}
  }

  /// This `R.file` struct is generated, and contains static references to 3 files.
  struct file {
    /// Resource file `GoogleService-Info.plist`.
    static let googleServiceInfoPlist = Rswift.FileResource(bundle: R.hostingBundle, name: "GoogleService-Info", pathExtension: "plist")
    /// Resource file `NotoSansKR-Medium.otf`.
    static let notoSansKRMediumOtf = Rswift.FileResource(bundle: R.hostingBundle, name: "NotoSansKR-Medium", pathExtension: "otf")
    /// Resource file `NotoSansKR-Regular.otf`.
    static let notoSansKRRegularOtf = Rswift.FileResource(bundle: R.hostingBundle, name: "NotoSansKR-Regular", pathExtension: "otf")

    /// `bundle.url(forResource: "GoogleService-Info", withExtension: "plist")`
    static func googleServiceInfoPlist(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.googleServiceInfoPlist
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "NotoSansKR-Medium", withExtension: "otf")`
    static func notoSansKRMediumOtf(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.notoSansKRMediumOtf
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "NotoSansKR-Regular", withExtension: "otf")`
    static func notoSansKRRegularOtf(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.notoSansKRRegularOtf
      return fileResource.bundle.url(forResource: fileResource)
    }

    fileprivate init() {}
  }

  /// This `R.font` struct is generated, and contains static references to 2 fonts.
  struct font: Rswift.Validatable {
    /// Font `NotoSansKR-Medium`.
    static let notoSansKRMedium = Rswift.FontResource(fontName: "NotoSansKR-Medium")
    /// Font `NotoSansKR-Regular`.
    static let notoSansKRRegular = Rswift.FontResource(fontName: "NotoSansKR-Regular")

    /// `UIFont(name: "NotoSansKR-Medium", size: ...)`
    static func notoSansKRMedium(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: notoSansKRMedium, size: size)
    }

    /// `UIFont(name: "NotoSansKR-Regular", size: ...)`
    static func notoSansKRRegular(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: notoSansKRRegular, size: size)
    }

    static func validate() throws {
      if R.font.notoSansKRMedium(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'NotoSansKR-Medium' could not be loaded, is 'NotoSansKR-Medium.otf' added to the UIAppFonts array in this targets Info.plist?") }
      if R.font.notoSansKRRegular(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'NotoSansKR-Regular' could not be loaded, is 'NotoSansKR-Regular.otf' added to the UIAppFonts array in this targets Info.plist?") }
    }

    fileprivate init() {}
  }

  /// This `R.image` struct is generated, and contains static references to 33 images.
  struct image {
    /// Image `SeSAC`.
    static let seSAC = Rswift.ImageResource(bundle: R.hostingBundle, name: "SeSAC")
    /// Image `Splash`.
    static let splash = Rswift.ImageResource(bundle: R.hostingBundle, name: "Splash")
    /// Image `arrow_down`.
    static let arrow_down = Rswift.ImageResource(bundle: R.hostingBundle, name: "arrow_down")
    /// Image `arrow_up`.
    static let arrow_up = Rswift.ImageResource(bundle: R.hostingBundle, name: "arrow_up")
    /// Image `defaultFloatingImage`.
    static let defaultFloatingImage = Rswift.ImageResource(bundle: R.hostingBundle, name: "defaultFloatingImage")
    /// Image `faq`.
    static let faq = Rswift.ImageResource(bundle: R.hostingBundle, name: "faq")
    /// Image `freindTapItem`.
    static let freindTapItem = Rswift.ImageResource(bundle: R.hostingBundle, name: "freindTapItem")
    /// Image `homeTapItem`.
    static let homeTapItem = Rswift.ImageResource(bundle: R.hostingBundle, name: "homeTapItem")
    /// Image `man`.
    static let man = Rswift.ImageResource(bundle: R.hostingBundle, name: "man")
    /// Image `matchedFloatingImage`.
    static let matchedFloatingImage = Rswift.ImageResource(bundle: R.hostingBundle, name: "matchedFloatingImage")
    /// Image `matchingFloatingImage`.
    static let matchingFloatingImage = Rswift.ImageResource(bundle: R.hostingBundle, name: "matchingFloatingImage")
    /// Image `myPageTapItem`.
    static let myPageTapItem = Rswift.ImageResource(bundle: R.hostingBundle, name: "myPageTapItem")
    /// Image `notice`.
    static let notice = Rswift.ImageResource(bundle: R.hostingBundle, name: "notice")
    /// Image `onboardingImg1`.
    static let onboardingImg1 = Rswift.ImageResource(bundle: R.hostingBundle, name: "onboardingImg1")
    /// Image `onboardingImg2`.
    static let onboardingImg2 = Rswift.ImageResource(bundle: R.hostingBundle, name: "onboardingImg2")
    /// Image `onboardingImg3`.
    static let onboardingImg3 = Rswift.ImageResource(bundle: R.hostingBundle, name: "onboardingImg3")
    /// Image `permit`.
    static let permit = Rswift.ImageResource(bundle: R.hostingBundle, name: "permit")
    /// Image `qna`.
    static let qna = Rswift.ImageResource(bundle: R.hostingBundle, name: "qna")
    /// Image `sesacFace`.
    static let sesacFace = Rswift.ImageResource(bundle: R.hostingBundle, name: "sesacFace")
    /// Image `sesac_background_1`.
    static let sesac_background_1 = Rswift.ImageResource(bundle: R.hostingBundle, name: "sesac_background_1")
    /// Image `sesac_background_2`.
    static let sesac_background_2 = Rswift.ImageResource(bundle: R.hostingBundle, name: "sesac_background_2")
    /// Image `sesac_background_3`.
    static let sesac_background_3 = Rswift.ImageResource(bundle: R.hostingBundle, name: "sesac_background_3")
    /// Image `sesac_background_4`.
    static let sesac_background_4 = Rswift.ImageResource(bundle: R.hostingBundle, name: "sesac_background_4")
    /// Image `sesac_background_5`.
    static let sesac_background_5 = Rswift.ImageResource(bundle: R.hostingBundle, name: "sesac_background_5")
    /// Image `sesac_face_1`.
    static let sesac_face_1 = Rswift.ImageResource(bundle: R.hostingBundle, name: "sesac_face_1")
    /// Image `sesac_face_2`.
    static let sesac_face_2 = Rswift.ImageResource(bundle: R.hostingBundle, name: "sesac_face_2")
    /// Image `sesac_face_3`.
    static let sesac_face_3 = Rswift.ImageResource(bundle: R.hostingBundle, name: "sesac_face_3")
    /// Image `sesac_face_4`.
    static let sesac_face_4 = Rswift.ImageResource(bundle: R.hostingBundle, name: "sesac_face_4")
    /// Image `sesac_face_5`.
    static let sesac_face_5 = Rswift.ImageResource(bundle: R.hostingBundle, name: "sesac_face_5")
    /// Image `setting_alarm`.
    static let setting_alarm = Rswift.ImageResource(bundle: R.hostingBundle, name: "setting_alarm")
    /// Image `shopTapItem`.
    static let shopTapItem = Rswift.ImageResource(bundle: R.hostingBundle, name: "shopTapItem")
    /// Image `splashLogo.png`.
    static let splashLogoPng = Rswift.ImageResource(bundle: R.hostingBundle, name: "splashLogo.png")
    /// Image `woman`.
    static let woman = Rswift.ImageResource(bundle: R.hostingBundle, name: "woman")

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "SeSAC", bundle: ..., traitCollection: ...)`
    static func seSAC(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.seSAC, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "Splash", bundle: ..., traitCollection: ...)`
    static func splash(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.splash, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "arrow_down", bundle: ..., traitCollection: ...)`
    static func arrow_down(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.arrow_down, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "arrow_up", bundle: ..., traitCollection: ...)`
    static func arrow_up(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.arrow_up, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "defaultFloatingImage", bundle: ..., traitCollection: ...)`
    static func defaultFloatingImage(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.defaultFloatingImage, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "faq", bundle: ..., traitCollection: ...)`
    static func faq(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.faq, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "freindTapItem", bundle: ..., traitCollection: ...)`
    static func freindTapItem(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.freindTapItem, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "homeTapItem", bundle: ..., traitCollection: ...)`
    static func homeTapItem(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.homeTapItem, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "man", bundle: ..., traitCollection: ...)`
    static func man(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.man, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "matchedFloatingImage", bundle: ..., traitCollection: ...)`
    static func matchedFloatingImage(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.matchedFloatingImage, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "matchingFloatingImage", bundle: ..., traitCollection: ...)`
    static func matchingFloatingImage(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.matchingFloatingImage, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "myPageTapItem", bundle: ..., traitCollection: ...)`
    static func myPageTapItem(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.myPageTapItem, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "notice", bundle: ..., traitCollection: ...)`
    static func notice(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.notice, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "onboardingImg1", bundle: ..., traitCollection: ...)`
    static func onboardingImg1(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.onboardingImg1, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "onboardingImg2", bundle: ..., traitCollection: ...)`
    static func onboardingImg2(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.onboardingImg2, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "onboardingImg3", bundle: ..., traitCollection: ...)`
    static func onboardingImg3(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.onboardingImg3, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "permit", bundle: ..., traitCollection: ...)`
    static func permit(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.permit, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "qna", bundle: ..., traitCollection: ...)`
    static func qna(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.qna, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "sesacFace", bundle: ..., traitCollection: ...)`
    static func sesacFace(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.sesacFace, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "sesac_background_1", bundle: ..., traitCollection: ...)`
    static func sesac_background_1(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.sesac_background_1, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "sesac_background_2", bundle: ..., traitCollection: ...)`
    static func sesac_background_2(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.sesac_background_2, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "sesac_background_3", bundle: ..., traitCollection: ...)`
    static func sesac_background_3(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.sesac_background_3, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "sesac_background_4", bundle: ..., traitCollection: ...)`
    static func sesac_background_4(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.sesac_background_4, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "sesac_background_5", bundle: ..., traitCollection: ...)`
    static func sesac_background_5(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.sesac_background_5, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "sesac_face_1", bundle: ..., traitCollection: ...)`
    static func sesac_face_1(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.sesac_face_1, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "sesac_face_2", bundle: ..., traitCollection: ...)`
    static func sesac_face_2(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.sesac_face_2, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "sesac_face_3", bundle: ..., traitCollection: ...)`
    static func sesac_face_3(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.sesac_face_3, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "sesac_face_4", bundle: ..., traitCollection: ...)`
    static func sesac_face_4(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.sesac_face_4, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "sesac_face_5", bundle: ..., traitCollection: ...)`
    static func sesac_face_5(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.sesac_face_5, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "setting_alarm", bundle: ..., traitCollection: ...)`
    static func setting_alarm(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.setting_alarm, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "shopTapItem", bundle: ..., traitCollection: ...)`
    static func shopTapItem(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.shopTapItem, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "splashLogo.png", bundle: ..., traitCollection: ...)`
    static func splashLogoPng(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.splashLogoPng, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "woman", bundle: ..., traitCollection: ...)`
    static func woman(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.woman, compatibleWith: traitCollection)
    }
    #endif

    fileprivate init() {}
  }

  /// This `R.info` struct is generated, and contains static references to 1 properties.
  struct info {
    struct uiApplicationSceneManifest {
      static let _key = "UIApplicationSceneManifest"
      static let uiApplicationSupportsMultipleScenes = false

      struct uiSceneConfigurations {
        static let _key = "UISceneConfigurations"

        struct uiWindowSceneSessionRoleApplication {
          struct defaultConfiguration {
            static let _key = "Default Configuration"
            static let uiSceneConfigurationName = infoPlistString(path: ["UIApplicationSceneManifest", "UISceneConfigurations", "UIWindowSceneSessionRoleApplication", "Default Configuration"], key: "UISceneConfigurationName") ?? "Default Configuration"
            static let uiSceneDelegateClassName = infoPlistString(path: ["UIApplicationSceneManifest", "UISceneConfigurations", "UIWindowSceneSessionRoleApplication", "Default Configuration"], key: "UISceneDelegateClassName") ?? "$(PRODUCT_MODULE_NAME).SceneDelegate"

            fileprivate init() {}
          }

          fileprivate init() {}
        }

        fileprivate init() {}
      }

      fileprivate init() {}
    }

    fileprivate init() {}
  }

  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      try _R.validate()
    }

    fileprivate init() {}
  }

  fileprivate class Class {}

  fileprivate init() {}
}

struct _R: Rswift.Validatable {
  static func validate() throws {
    #if os(iOS) || os(tvOS)
    try storyboard.validate()
    #endif
  }

  #if os(iOS) || os(tvOS)
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      #if os(iOS) || os(tvOS)
      try launchScreen.validate()
      #endif
    }

    #if os(iOS) || os(tvOS)
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UIViewController

      let bundle = R.hostingBundle
      let name = "LaunchScreen"

      static func validate() throws {
        if UIKit.UIImage(named: "splashLogo.png", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'splashLogo.png' is used in storyboard 'LaunchScreen', but couldn't be loaded.") }
        if #available(iOS 11.0, tvOS 11.0, *) {
          if UIKit.UIColor(named: "green", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Color named 'green' is used in storyboard 'LaunchScreen', but couldn't be loaded.") }
        }
      }

      fileprivate init() {}
    }
    #endif

    fileprivate init() {}
  }
  #endif

  fileprivate init() {}
}
