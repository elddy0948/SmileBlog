import Foundation

public enum NetworkError: Error {
  case notFound
  case invalidURL
  case invalidRequest
  case invalidStatusCode
  case invalidData
  case failedDecoding
}

final class NetworkService {
  static let baseURL = "http://localhost:8080"
  
  static func fetch<T: Decodable>(
    of type: T.Type = T.self,
    endPoint: String,
    completion: @escaping(Result<T, NetworkError>) -> Void
  ) {
    guard let url = URL(string: baseURL + endPoint) else {
      completion(.failure(.invalidURL))
      return
    }
    
    let request = URLRequest(url: url)
    
    let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
      if let _ = error {
        completion(.failure(.invalidRequest))
        return
      }
      
      guard let response = response as? HTTPURLResponse,
            (200 ..< 300) ~= response.statusCode else {
        completion(.failure(.invalidStatusCode))
        return
      }
      
      if let data = data {
        do {
          let decodedData = try JSONDecoder().decode(T.self, from: data)
          completion(.success(decodedData))
          return
        } catch {
          completion(.failure(.failedDecoding))
          return
        }
      } else {
        completion(.failure(.invalidData))
        return
      }
    })
    
    task.resume()
  }
}
