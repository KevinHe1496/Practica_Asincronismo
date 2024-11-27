

import Foundation

protocol NetworkLoginProtocol {
    func loginApp(user: String, password: String) async -> String
}

final class NetworkLogin: NetworkLoginProtocol {
    func loginApp(user: String, password: String) async -> String {
        var tokenJWT: String = ""
        let urlString: String = "\(ConstantsApp.CONST_API_URL)\(EndPoints.login.rawValue)"
        let encodeCredentials = "\(user):\(password)".data(using: .utf8)?.base64EncodedString()
        var segCredential: String = ""
        if let credentials = encodeCredentials {
            segCredential = "Basic \(credentials)"
        }
        
        guard  let url = URL(string: urlString) else {
            return ""
        }
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = HTTPMethods.post
        request.addValue(HTTPMethods.content, forHTTPHeaderField: "Content-Type")
        request.addValue(segCredential, forHTTPHeaderField: "Authorization")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            if let resp = response as? HTTPURLResponse,
               resp.statusCode == HTTPReponseCodes.SUCCESS {
                tokenJWT = String(decoding: data, as: UTF8.self)
            }
        } catch {
            tokenJWT = ""
        }
        return tokenJWT
    }
}



final class NetworkLoginFake: NetworkLoginProtocol {
    func loginApp(user: String, password: String) async -> String {
        return UUID().uuidString
    }
}
