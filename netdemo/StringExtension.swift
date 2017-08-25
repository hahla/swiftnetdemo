import Foundation

extension String {
    func addingPercentEncodingForFormUrlencoded() -> String {
        let allowedCharacters = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-._* ")
        
        return addingPercentEncoding(withAllowedCharacters: allowedCharacters)!.replacingOccurrences(of: " ", with: "+")
    }
}
