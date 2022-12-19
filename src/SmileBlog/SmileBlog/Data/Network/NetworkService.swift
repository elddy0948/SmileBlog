import Foundation

final class NetworkService {
  static func fetchUser(with id: String, completion: @escaping(Result<UserResponseDTO, Error>) -> Void) {
    let endPoint = "http://localhost:8080/api/users/\(id)"
    let url = URL(string: endPoint)!
    let request = URLRequest(url: url)
    
    URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
      if let error = error {
        completion(.failure(error))
        return
      }
      
      guard let response = response as? HTTPURLResponse,
            (200 ..< 300) ~= response.statusCode else {
        return
      }
      
      if let data = data {
        do {
          let user = try JSONDecoder().decode(UserResponseDTO.self, from: data)
          completion(.success(user))
        } catch let error {
          completion(.failure(error))
        }
      }
    }).resume()
  }
  
  static func fetchPost(with id: String, completion: @escaping (Result<PostResponseDTO, Error>) -> Void) {
    let endPoint = "http://localhost:8080/api/posts/\(id)"
    let url = URL(string: endPoint)!
    let request = URLRequest(url: url)
    
    URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
      if let error = error {
        completion(.failure(error))
        return
      }
      
      guard let response = response as? HTTPURLResponse,
            (200 ..< 300) ~= response.statusCode else {
        return
      }
      
      if let data = data {
        do {
          let post = try JSONDecoder().decode(PostResponseDTO.self, from: data)
          completion(.success(post))
        } catch let error {
          completion(.failure(error))
        }
      }
    }).resume()
    
  }
}
