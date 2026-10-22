// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let version = "0.7.0"
let checksum = "0000000000000000000000000000000000000000000000000000000000000000"

let klippaIdentityVerificationXCFramework = Target.binaryTarget(
    name: "KlippaIdentityVerification",
    url: "https://custom-ocr.klippa.com/sdk/ios/spm/KlippaIdentityVerification/\(version)-xcframework.zip",
    checksum: checksum
)

let package = Package(
    name: "KlippaIdentityVerification",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "KlippaIdentityVerification",
            targets: ["KlippaIdentityVerification", "_KlippaIdentityVerificationStub"]
        ),
    ],
    targets: [
        klippaIdentityVerificationXCFramework,

        // Without at least one regular (non-binary) target, this package doesn't show up
        // in Xcode under "Frameworks, Libraries, and Embedded Content". That prevents
        // KlippaIdentityVerification from being embedded in the app product, causing the app to crash when
        // ran on a physical device. As a workaround, we can include a stub target
        // with at least one source file.
        // https://github.com/apple/swift-package-manager/issues/6069
        .target(
            name: "_KlippaIdentityVerificationStub"
        )
    ]
)
