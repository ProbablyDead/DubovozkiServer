import Vapor

// MARK: - Routes
func routes(_ app: Application) throws {
    app.get("data", "getData", use: getData)
    
    app.post("auth", "signIn", use: signIn)
    app.post("auth", "signUp", use: signUp)
    app.post("auth", "resetPassword", use: resetPassword)
}

