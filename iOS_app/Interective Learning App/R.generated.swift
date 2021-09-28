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
  /// This `R.storyboard` struct is generated, and contains static references to 4 storyboards.
  struct storyboard {
    /// Storyboard `CustomizeViewController`.
    static let customizeViewController = _R.storyboard.customizeViewController()
    /// Storyboard `HomeViewController`.
    static let homeViewController = _R.storyboard.homeViewController()
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()
    /// Storyboard `StageViewController`.
    static let stageViewController = _R.storyboard.stageViewController()

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "CustomizeViewController", bundle: ...)`
    static func customizeViewController(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.customizeViewController)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "HomeViewController", bundle: ...)`
    static func homeViewController(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.homeViewController)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "StageViewController", bundle: ...)`
    static func stageViewController(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.stageViewController)
    }
    #endif

    fileprivate init() {}
  }
  #endif

  /// This `R.color` struct is generated, and contains static references to 5 colors.
  struct color {
    /// Color `AccentColor`.
    static let accentColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "AccentColor")
    /// Color `lightBlue`.
    static let lightBlue = Rswift.ColorResource(bundle: R.hostingBundle, name: "lightBlue")
    /// Color `lightGreen`.
    static let lightGreen = Rswift.ColorResource(bundle: R.hostingBundle, name: "lightGreen")
    /// Color `lightGrey`.
    static let lightGrey = Rswift.ColorResource(bundle: R.hostingBundle, name: "lightGrey")
    /// Color `lightYellow`.
    static let lightYellow = Rswift.ColorResource(bundle: R.hostingBundle, name: "lightYellow")

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "AccentColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func accentColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.accentColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "lightBlue", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func lightBlue(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.lightBlue, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "lightGreen", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func lightGreen(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.lightGreen, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "lightGrey", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func lightGrey(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.lightGrey, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "lightYellow", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func lightYellow(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.lightYellow, compatibleWith: traitCollection)
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
    /// `UIColor(named: "lightBlue", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func lightBlue(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.lightBlue.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "lightGreen", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func lightGreen(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.lightGreen.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "lightGrey", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func lightGrey(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.lightGrey.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "lightYellow", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func lightYellow(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.lightYellow.name)
    }
    #endif

    fileprivate init() {}
  }

  /// This `R.file` struct is generated, and contains static references to 20 files.
  struct file {
    /// Resource file `SairaSemiCondensed-Black.ttf`.
    static let sairaSemiCondensedBlackTtf = Rswift.FileResource(bundle: R.hostingBundle, name: "SairaSemiCondensed-Black", pathExtension: "ttf")
    /// Resource file `SairaSemiCondensed-Bold.ttf`.
    static let sairaSemiCondensedBoldTtf = Rswift.FileResource(bundle: R.hostingBundle, name: "SairaSemiCondensed-Bold", pathExtension: "ttf")
    /// Resource file `SairaSemiCondensed-ExtraBold.ttf`.
    static let sairaSemiCondensedExtraBoldTtf = Rswift.FileResource(bundle: R.hostingBundle, name: "SairaSemiCondensed-ExtraBold", pathExtension: "ttf")
    /// Resource file `SairaSemiCondensed-ExtraLight.ttf`.
    static let sairaSemiCondensedExtraLightTtf = Rswift.FileResource(bundle: R.hostingBundle, name: "SairaSemiCondensed-ExtraLight", pathExtension: "ttf")
    /// Resource file `SairaSemiCondensed-Light.ttf`.
    static let sairaSemiCondensedLightTtf = Rswift.FileResource(bundle: R.hostingBundle, name: "SairaSemiCondensed-Light", pathExtension: "ttf")
    /// Resource file `SairaSemiCondensed-Medium.ttf`.
    static let sairaSemiCondensedMediumTtf = Rswift.FileResource(bundle: R.hostingBundle, name: "SairaSemiCondensed-Medium", pathExtension: "ttf")
    /// Resource file `SairaSemiCondensed-Regular.ttf`.
    static let sairaSemiCondensedRegularTtf = Rswift.FileResource(bundle: R.hostingBundle, name: "SairaSemiCondensed-Regular", pathExtension: "ttf")
    /// Resource file `SairaSemiCondensed-SemiBold.ttf`.
    static let sairaSemiCondensedSemiBoldTtf = Rswift.FileResource(bundle: R.hostingBundle, name: "SairaSemiCondensed-SemiBold", pathExtension: "ttf")
    /// Resource file `SairaSemiCondensed-Thin.ttf`.
    static let sairaSemiCondensedThinTtf = Rswift.FileResource(bundle: R.hostingBundle, name: "SairaSemiCondensed-Thin", pathExtension: "ttf")
    /// Resource file `alim.png`.
    static let alimPng = Rswift.FileResource(bundle: R.hostingBundle, name: "alim", pathExtension: "png")
    /// Resource file `bogdan.png`.
    static let bogdanPng = Rswift.FileResource(bundle: R.hostingBundle, name: "bogdan", pathExtension: "png")
    /// Resource file `gordon.png`.
    static let gordonPng = Rswift.FileResource(bundle: R.hostingBundle, name: "gordon", pathExtension: "png")
    /// Resource file `ljspeech.wav`.
    static let ljspeechWav = Rswift.FileResource(bundle: R.hostingBundle, name: "ljspeech", pathExtension: "wav")
    /// Resource file `multispeaker.wav`.
    static let multispeakerWav = Rswift.FileResource(bundle: R.hostingBundle, name: "multispeaker", pathExtension: "wav")
    /// Resource file `netherlands.wav`.
    static let netherlandsWav = Rswift.FileResource(bundle: R.hostingBundle, name: "netherlands", pathExtension: "wav")
    /// Resource file `oksi.png`.
    static let oksiPng = Rswift.FileResource(bundle: R.hostingBundle, name: "oksi", pathExtension: "png")
    /// Resource file `pasha.png`.
    static let pashaPng = Rswift.FileResource(bundle: R.hostingBundle, name: "pasha", pathExtension: "png")
    /// Resource file `pashatech.png`.
    static let pashatechPng = Rswift.FileResource(bundle: R.hostingBundle, name: "pashatech", pathExtension: "png")
    /// Resource file `sasha.png`.
    static let sashaPng = Rswift.FileResource(bundle: R.hostingBundle, name: "sasha", pathExtension: "png")
    /// Resource file `savateev.png`.
    static let savateevPng = Rswift.FileResource(bundle: R.hostingBundle, name: "savateev", pathExtension: "png")

    /// `bundle.url(forResource: "SairaSemiCondensed-Black", withExtension: "ttf")`
    static func sairaSemiCondensedBlackTtf(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.sairaSemiCondensedBlackTtf
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "SairaSemiCondensed-Bold", withExtension: "ttf")`
    static func sairaSemiCondensedBoldTtf(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.sairaSemiCondensedBoldTtf
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "SairaSemiCondensed-ExtraBold", withExtension: "ttf")`
    static func sairaSemiCondensedExtraBoldTtf(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.sairaSemiCondensedExtraBoldTtf
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "SairaSemiCondensed-ExtraLight", withExtension: "ttf")`
    static func sairaSemiCondensedExtraLightTtf(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.sairaSemiCondensedExtraLightTtf
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "SairaSemiCondensed-Light", withExtension: "ttf")`
    static func sairaSemiCondensedLightTtf(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.sairaSemiCondensedLightTtf
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "SairaSemiCondensed-Medium", withExtension: "ttf")`
    static func sairaSemiCondensedMediumTtf(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.sairaSemiCondensedMediumTtf
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "SairaSemiCondensed-Regular", withExtension: "ttf")`
    static func sairaSemiCondensedRegularTtf(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.sairaSemiCondensedRegularTtf
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "SairaSemiCondensed-SemiBold", withExtension: "ttf")`
    static func sairaSemiCondensedSemiBoldTtf(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.sairaSemiCondensedSemiBoldTtf
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "SairaSemiCondensed-Thin", withExtension: "ttf")`
    static func sairaSemiCondensedThinTtf(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.sairaSemiCondensedThinTtf
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "alim", withExtension: "png")`
    static func alimPng(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.alimPng
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "bogdan", withExtension: "png")`
    static func bogdanPng(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.bogdanPng
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "gordon", withExtension: "png")`
    static func gordonPng(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.gordonPng
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "ljspeech", withExtension: "wav")`
    static func ljspeechWav(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.ljspeechWav
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "multispeaker", withExtension: "wav")`
    static func multispeakerWav(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.multispeakerWav
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "netherlands", withExtension: "wav")`
    static func netherlandsWav(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.netherlandsWav
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "oksi", withExtension: "png")`
    static func oksiPng(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.oksiPng
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "pasha", withExtension: "png")`
    static func pashaPng(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.pashaPng
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "pashatech", withExtension: "png")`
    static func pashatechPng(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.pashatechPng
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "sasha", withExtension: "png")`
    static func sashaPng(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.sashaPng
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "savateev", withExtension: "png")`
    static func savateevPng(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.savateevPng
      return fileResource.bundle.url(forResource: fileResource)
    }

    fileprivate init() {}
  }

  /// This `R.font` struct is generated, and contains static references to 9 fonts.
  struct font: Rswift.Validatable {
    /// Font `SairaSemiCondensed-Black`.
    static let sairaSemiCondensedBlack = Rswift.FontResource(fontName: "SairaSemiCondensed-Black")
    /// Font `SairaSemiCondensed-Bold`.
    static let sairaSemiCondensedBold = Rswift.FontResource(fontName: "SairaSemiCondensed-Bold")
    /// Font `SairaSemiCondensed-ExtraBold`.
    static let sairaSemiCondensedExtraBold = Rswift.FontResource(fontName: "SairaSemiCondensed-ExtraBold")
    /// Font `SairaSemiCondensed-ExtraLight`.
    static let sairaSemiCondensedExtraLight = Rswift.FontResource(fontName: "SairaSemiCondensed-ExtraLight")
    /// Font `SairaSemiCondensed-Light`.
    static let sairaSemiCondensedLight = Rswift.FontResource(fontName: "SairaSemiCondensed-Light")
    /// Font `SairaSemiCondensed-Medium`.
    static let sairaSemiCondensedMedium = Rswift.FontResource(fontName: "SairaSemiCondensed-Medium")
    /// Font `SairaSemiCondensed-Regular`.
    static let sairaSemiCondensedRegular = Rswift.FontResource(fontName: "SairaSemiCondensed-Regular")
    /// Font `SairaSemiCondensed-SemiBold`.
    static let sairaSemiCondensedSemiBold = Rswift.FontResource(fontName: "SairaSemiCondensed-SemiBold")
    /// Font `SairaSemiCondensed-Thin`.
    static let sairaSemiCondensedThin = Rswift.FontResource(fontName: "SairaSemiCondensed-Thin")

    /// `UIFont(name: "SairaSemiCondensed-Black", size: ...)`
    static func sairaSemiCondensedBlack(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: sairaSemiCondensedBlack, size: size)
    }

    /// `UIFont(name: "SairaSemiCondensed-Bold", size: ...)`
    static func sairaSemiCondensedBold(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: sairaSemiCondensedBold, size: size)
    }

    /// `UIFont(name: "SairaSemiCondensed-ExtraBold", size: ...)`
    static func sairaSemiCondensedExtraBold(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: sairaSemiCondensedExtraBold, size: size)
    }

    /// `UIFont(name: "SairaSemiCondensed-ExtraLight", size: ...)`
    static func sairaSemiCondensedExtraLight(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: sairaSemiCondensedExtraLight, size: size)
    }

    /// `UIFont(name: "SairaSemiCondensed-Light", size: ...)`
    static func sairaSemiCondensedLight(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: sairaSemiCondensedLight, size: size)
    }

    /// `UIFont(name: "SairaSemiCondensed-Medium", size: ...)`
    static func sairaSemiCondensedMedium(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: sairaSemiCondensedMedium, size: size)
    }

    /// `UIFont(name: "SairaSemiCondensed-Regular", size: ...)`
    static func sairaSemiCondensedRegular(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: sairaSemiCondensedRegular, size: size)
    }

    /// `UIFont(name: "SairaSemiCondensed-SemiBold", size: ...)`
    static func sairaSemiCondensedSemiBold(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: sairaSemiCondensedSemiBold, size: size)
    }

    /// `UIFont(name: "SairaSemiCondensed-Thin", size: ...)`
    static func sairaSemiCondensedThin(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: sairaSemiCondensedThin, size: size)
    }

    static func validate() throws {
      if R.font.sairaSemiCondensedBlack(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'SairaSemiCondensed-Black' could not be loaded, is 'SairaSemiCondensed-Black.ttf' added to the UIAppFonts array in this targets Info.plist?") }
      if R.font.sairaSemiCondensedBold(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'SairaSemiCondensed-Bold' could not be loaded, is 'SairaSemiCondensed-Bold.ttf' added to the UIAppFonts array in this targets Info.plist?") }
      if R.font.sairaSemiCondensedExtraBold(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'SairaSemiCondensed-ExtraBold' could not be loaded, is 'SairaSemiCondensed-ExtraBold.ttf' added to the UIAppFonts array in this targets Info.plist?") }
      if R.font.sairaSemiCondensedExtraLight(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'SairaSemiCondensed-ExtraLight' could not be loaded, is 'SairaSemiCondensed-ExtraLight.ttf' added to the UIAppFonts array in this targets Info.plist?") }
      if R.font.sairaSemiCondensedLight(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'SairaSemiCondensed-Light' could not be loaded, is 'SairaSemiCondensed-Light.ttf' added to the UIAppFonts array in this targets Info.plist?") }
      if R.font.sairaSemiCondensedMedium(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'SairaSemiCondensed-Medium' could not be loaded, is 'SairaSemiCondensed-Medium.ttf' added to the UIAppFonts array in this targets Info.plist?") }
      if R.font.sairaSemiCondensedRegular(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'SairaSemiCondensed-Regular' could not be loaded, is 'SairaSemiCondensed-Regular.ttf' added to the UIAppFonts array in this targets Info.plist?") }
      if R.font.sairaSemiCondensedSemiBold(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'SairaSemiCondensed-SemiBold' could not be loaded, is 'SairaSemiCondensed-SemiBold.ttf' added to the UIAppFonts array in this targets Info.plist?") }
      if R.font.sairaSemiCondensedThin(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'SairaSemiCondensed-Thin' could not be loaded, is 'SairaSemiCondensed-Thin.ttf' added to the UIAppFonts array in this targets Info.plist?") }
    }

    fileprivate init() {}
  }

  /// This `R.image` struct is generated, and contains static references to 1 images.
  struct image {
    /// Image `image`.
    static let image = Rswift.ImageResource(bundle: R.hostingBundle, name: "image")

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "image", bundle: ..., traitCollection: ...)`
    static func image(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.image, compatibleWith: traitCollection)
    }
    #endif

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
      try customizeViewController.validate()
      #endif
      #if os(iOS) || os(tvOS)
      try homeViewController.validate()
      #endif
      #if os(iOS) || os(tvOS)
      try launchScreen.validate()
      #endif
      #if os(iOS) || os(tvOS)
      try stageViewController.validate()
      #endif
    }

    #if os(iOS) || os(tvOS)
    struct customizeViewController: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = CustomizeViewController

      let bundle = R.hostingBundle
      let name = "CustomizeViewController"

      static func validate() throws {
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
      }

      fileprivate init() {}
    }
    #endif

    #if os(iOS) || os(tvOS)
    struct homeViewController: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = HomeViewController

      let bundle = R.hostingBundle
      let name = "HomeViewController"

      static func validate() throws {
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
      }

      fileprivate init() {}
    }
    #endif

    #if os(iOS) || os(tvOS)
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UIViewController

      let bundle = R.hostingBundle
      let name = "LaunchScreen"

      static func validate() throws {
        if UIKit.UIImage(named: "image", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'image' is used in storyboard 'LaunchScreen', but couldn't be loaded.") }
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
      }

      fileprivate init() {}
    }
    #endif

    #if os(iOS) || os(tvOS)
    struct stageViewController: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = StageViewController

      let bundle = R.hostingBundle
      let name = "StageViewController"

      static func validate() throws {
        if #available(iOS 11.0, tvOS 11.0, *) {
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
