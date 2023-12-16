import Vapor
import Ferno

// configures your application
public func configure(_ app: Application) async throws {
    // ferno config
    let fernoConfiguration = FernoDefaultConfiguration(
        basePath: "https://dubki-app-default-rtdb.firebaseio.com",
        email: "firebase-adminsdk-40kp7@dubki-app.iam.gserviceaccount.com",
        privateKey: ProcessInfo.processInfo.environment["PRIVATE_KEY"] ?? ""
    )
    
    // apply config
    app.ferno.use(.default(fernoConfiguration))
    
    // register routes
    try routes(app)
}
