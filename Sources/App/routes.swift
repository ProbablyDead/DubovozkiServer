import Vapor

func routes(_ app: Application) throws {
    app.post("signIn", use: signIn)
    app.post("signUp", use: signUp)
    app.post("resetPassword", use: resetPassword)
}

