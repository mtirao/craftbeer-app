import ProjectDescription

let project = Project(
    name: "Craftbeer",
    targets: [
        Target(
            name: "Craftbeer.iOS",
            platform: .iOS,
            product: .app,
            bundleId: "ar.com.wanaka.Craftbeer",
            sources: ["Shared/**", "iOS/**"],
            entitlements: "Craftbeer (iOS).entitlements"
        )
    ]
)
