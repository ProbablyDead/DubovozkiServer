import Vapor
import Ferno

// configures your application
public func configure(_ app: Application) async throws {
    let configPath = app.directory.resourcesDirectory.appending("firebase-adminsdk.json")
    let configData = try Data(contentsOf: URL(fileURLWithPath: configPath))
    
    let fernoConfiguration = try FernoServiceJsonConfiguration(json: configData)
    
    // register routes
    try routes(app)
}
