//
//  File.swift
//  
//
//  Created by Илья Володин on 16.12.2023.
//

import Vapor
// type alias for request body
typealias Body = [String: String]

// MARK: - SendRequest function, returns response
private func sendRequest(requestType: RequestType, req: Request) throws -> EventLoopFuture<String> {
    let user: User = try req.content.decode(User.self)
    let content: Body = requestType.getRequestBody(user: user)
    
    return req.client.post(URI(string: requestType.requestString)) { postRequest in
        postRequest.headers.add(name: BodyParametersNames.contentType, value: BodyParametersNames.contentTypeValue)
        try postRequest.content.encode(content)
    }.flatMap { response in
        if response.status == .ok {
            if requestType == RequestType.resetPassword {
                return req.eventLoop.future("")
            }
            
            struct AuthResponse: Content {
                let idToken: String
            }
            
            do {
                return req.eventLoop.future(try response.content.decode(AuthResponse.self).idToken)
            } catch {
                return req.eventLoop.future(error: Abort(.badRequest, reason: "Failure decoding"))
            }
            
        } else {
            return req.eventLoop.future(error: Abort(response.status, reason: response.description))
        }
    }
}

// MARK: - signIn handler
func signIn(req: Request) throws -> EventLoopFuture<String> {
    do {
        return try sendRequest(requestType: RequestType.signIn, req: req)
    } catch {
        return req.eventLoop.future(error: error)
    }
}

// MARK: - signUp handler
func signUp(req: Request) throws -> EventLoopFuture<String> {
    do {
        return try sendRequest(requestType: RequestType.signUp, req: req)
    } catch {
        return req.eventLoop.future(error: error)
    }
}

// MARK: - reset password handler
func resetPassword(req: Request) throws -> EventLoopFuture<String> {
    do {
        return try sendRequest(requestType: RequestType.resetPassword, req: req)
    } catch {
        return req.eventLoop.future(error: error)
    }
}

// MARK: - User struct
private struct User: Content {
    let email: String
    let password: String?
}

// MARK: - Assembling request enum
private enum RequestType: String {
    static let adress: String = "https://identitytoolkit.googleapis.com/v1/accounts:"
    static let key: String = {
        if let webApiKey = ProcessInfo.processInfo.environment["WEB_API_KEY"] {
            return "?key=\(webApiKey)"
        }
        return ""
    }()
    
    case signIn = "signInWithPassword"
    case signUp = "signUp"
    case resetPassword = "sendOobCode"
    
    var requestString: String {
        RequestType.adress + self.rawValue + RequestType.key
    }
    
    func getRequestBody(user: User) -> Body {
        var body: Body = [:]
        
        body[BodyParametersNames.email] = user.email
        
        switch self {
        case .signIn, .signUp:
            body[BodyParametersNames.password] = user.password
        case .resetPassword:
            body[BodyParametersNames.typeOfOobRequest] = BodyParametersNames.typeOfOobRequestValue
        }
        
        return body
    }
}

//MARK: - Names of request's body parameters 
private enum BodyParametersNames {
    static let contentType: String = "Content-Type"
    static let contentTypeValue: String = "application/json"
    
    static let email: String = "email"
    static let password: String = "password"
    static let typeOfOobRequest: String = "requestType"
    static let typeOfOobRequestValue: String = "PASSWORD_RESET"
}
