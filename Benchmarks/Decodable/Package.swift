import PackageDescription

let package = Package(
    name: "DecodablePerformance",
    dependencies: [
      .Package(url: "../..", majorVersion: 0),
      .Package(url: "https://github.com/anviking/decodable", majorVersion: 0, minor: 5)
    ]
)
