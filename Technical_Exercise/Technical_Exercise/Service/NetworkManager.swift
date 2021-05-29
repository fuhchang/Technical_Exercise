//
//  NetworkManager.swift
//  Technical_Exercise
//
//  Created by Fuh chang Loi on 29/5/21.
//

import Foundation

class NetworkManager {
    public static let shared = NetworkManager()
    private let session = URLSession.shared
    func urlSessionCall(urlString: String, completion: @escaping (_ response: Any?, _ error: Error?) -> Void) {
        if let url = URL(string: urlString){
            session.dataTask(with: url, completionHandler: { data, response, error in
                guard let data = data, error == nil else {
                            print(error?.localizedDescription ?? "No data")
                    return
                }
                completion(data, error)
            }).resume()
        }
    }
    
    func getDataFromJsonString(data: Any) -> Data? {
        do {
            return try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
        } catch let error {
            Swift.print(error)
        }
        return nil
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
