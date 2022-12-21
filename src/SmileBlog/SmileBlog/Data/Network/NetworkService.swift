import Foundation

public enum NetworkError: Error {
  case notFound
  case invalidURL
  case invalidRequest
  case invalidStatusCode
  case invalidData
  case failedDecoding
  case failedEncoding
  case failedToCreateURL
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
  
  static func create<E: Encodable, D: Decodable>(
    requestType: E.Type = E.self,
    responseType: D.Type = D.self,
    encodableData: E,
    endPoint: String,
    completion: @escaping (Result<D, NetworkError>) -> Void
  ) {
    guard let url = URL(string: baseURL + endPoint) else {
      completion(.failure(.invalidURL))
      return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    do {
      let encodedData = try JSONEncoder().encode(encodableData)
      request.httpBody = encodedData
    } catch {
      completion(.failure(.failedEncoding))
    }
    
    let task = URLSession.shared.dataTask(
      with: request,
      completionHandler: { data, response, error in
        if let _ = error {
          completion(.failure(.invalidRequest))
          return
        }
        
        guard let response = response as? HTTPURLResponse,
              (200 ..< 300) ~= response.statusCode else {
          completion(.failure(.invalidStatusCode))
          return
        }
        
        guard let data = data else {
          completion(.failure(.invalidData))
          return
        }
        
        do {
          let decodedData = try JSONDecoder().decode(D.self, from: data)
          completion(.success(decodedData))
          return
        } catch {
          completion(.failure(.failedDecoding))
          return
        }
      })
    
    task.resume()
  }
  
  static func search<T: Decodable>(
    of type: T.Type = T.self,
    endPoint: String,
    field: String,
    key: String,
    completion: @escaping (Result<T, NetworkError>) -> Void
  ) {
    guard var urlComponents = URLComponents(string: baseURL + endPoint) else {
      completion(.failure(.invalidURL))
      return
    }
    
    urlComponents.queryItems = [
      URLQueryItem(name: field, value: key)
    ]
    
    guard let url = urlComponents.url else {
      completion(.failure(.failedToCreateURL))
      return
    }
  
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    
    let task = URLSession.shared.dataTask(
      with: request,
      completionHandler: { data, response, error in
        if let _ = error {
          completion(.failure(.invalidRequest))
          return
        }
        
        guard let response = response as? HTTPURLResponse,
              (200 ..< 300) ~= response.statusCode else {
          completion(.failure(.invalidStatusCode))
          return
        }
        
        guard let data = data else {
          completion(.failure(.invalidData))
          return
        }
        
        do {
          let decodedData = try JSONDecoder().decode(T.self, from: data)
          completion(.success(decodedData))
          return
        } catch {
          completion(.failure(.failedDecoding))
          return
        }
      })
    
    task.resume()
  }
}
