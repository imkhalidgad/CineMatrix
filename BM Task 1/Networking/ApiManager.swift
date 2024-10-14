//
//  ApiManager.swift
//  BM Task 1
//
//  Created by Apple on 25/07/2024.
//

import Foundation
import Alamofire

class ApiManager {
    static func getShows(search: String, completion: @escaping (_ error: Error?, _ tvShowArr: [TVShowsResponse]?) -> Void) {
        let url = "https://api.tvmaze.com/search/shows"
        let parameters: [String: Any] = ["q": search]

        AF.request(url, method: .get, parameters: parameters).response { response in
            debugPrint(response)
            
            if let error = response.error {
                print("Request error: \(error.localizedDescription)")
                completion(error, nil)
                return
            }

            guard let data = response.data else {
                print("No data received")
                completion(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"]), nil)
                return
            }

            do {
                let decoder = JSONDecoder()
                let tvShowArr = try decoder.decode([TVShowsResponse].self, from: data)
                completion(nil, tvShowArr)
            } catch let decodingError {
                print("Decoding error: \(decodingError.localizedDescription)")
                completion(decodingError, nil)
            }
        }
    }
}
