import Vapor

func routes(_ app: Application) throws {
    app.post("auth", "signIn", use: signIn)
    app.post("auth", "signUp", use: signUp)
    app.post("auth", "resetPassword", use: resetPassword)
}

