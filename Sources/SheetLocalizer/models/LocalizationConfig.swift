//
//  Created by jorge on 20/6/25.
//

// MARK: - Configuration
public struct LocalizationConfig: Sendable {
    
    public let outputDirectory: String
    public let enumName: String
    public let sourceDirectory: String
    public let csvFileName: String
    
    public init(
        outputDirectory: String,
        enumName: String,
        sourceDirectory: String,
        csvFileName: String
    ) {
        self.outputDirectory = outputDirectory
        self.enumName = enumName
        self.sourceDirectory = sourceDirectory
        self.csvFileName = csvFileName
    }
    
    public static let `default` = LocalizationConfig(
        outputDirectory: "./",
        enumName: "JMR",
        sourceDirectory: "./Sources/SheetLocalizer",
        csvFileName: "localizables.csv"
    )
    
    public static func custom(
        outputDirectory: String = "./",
        enumName: String = "JMR",
        sourceDirectory: String = "./Sources/SheetLocalizer",
        csvFileName: String = "localizables.csv"
    ) -> LocalizationConfig {
        LocalizationConfig(
            outputDirectory: outputDirectory,
            enumName: enumName,
            sourceDirectory: sourceDirectory,
            csvFileName: csvFileName
        )
    }
}

public extension LocalizationConfig {
    init(arguments args: [String]) {
        var config = LocalizationConfig.default

        for i in 2..<args.count {
            let arg = args[i]
            if arg.hasPrefix("--enum=") {
                let enumName = String(arg.dropFirst(7))
                config = LocalizationConfig.custom(
                    outputDirectory: config.outputDirectory,
                    enumName: enumName,
                    sourceDirectory: config.sourceDirectory,
                    csvFileName: config.csvFileName
                )
            } else if arg.hasPrefix("--output=") {
                let outputDir = String(arg.dropFirst(9))
                config = LocalizationConfig.custom(
                    outputDirectory: outputDir,
                    enumName: config.enumName,
                    sourceDirectory: config.sourceDirectory,
                    csvFileName: config.csvFileName
                )
            }
        }
        
        self = config
    }
}

