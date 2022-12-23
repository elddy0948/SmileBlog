import Foundation

final class NetworkPostsRepository: PostsRepository {
  func create(post: Post, completion: @escaping (Result<Post, Error>) -> Void) {
    let postRequest = PostRequestDTO(
      title: post.title,
      body: post.body,
      writer: post.writer,
      userID: post.user
    )
    
    NetworkService.create(
      encodableData: postRequest,
      endPoint: "/api/posts",
      completion: { (result: Result<PostResponseDTO, NetworkError>) in
        switch result {
        case .success(let postResponse):
          let post = postResponse.toDomain()
          completion(.success(post))
          return
        case .failure(let error):
          completion(.failure(error))
          return
        }
      })
  }
  
  func fetchPost(postID: String, completion: @escaping (Result<Post, Error>) -> Void) {
    NetworkService.fetch(
      endPoint: "/api/posts/\(postID)",
      completion: { (result: Result<PostResponseDTO, NetworkError>) in
        switch result {
        case .success(let postResponse):
          let post = postResponse.toDomain()
          completion(.success(post))
          return
        case .failure(let error):
          completion(.failure(error))
          return
        }
      })
  }
  
  func fetchPosts(completion: @escaping (Result<[Post], Error>) -> Void) {
    NetworkService.fetch(
      endPoint: "/api/posts/",
      completion: { (result: Result<[PostResponseDTO], NetworkError>) in
        switch result {
        case .success(let postResponses):
          let posts = postResponses.map({ $0.toDomain() })
          completion(.success(posts))
          return
        case .failure(let error):
          completion(.failure(error))
          return
        }
      })
  }
  
  func fetchPostsUser(postID: String, completion: @escaping (Result<User, Error>) -> Void) {
    NetworkService.fetch(
      endPoint: "/api/posts/\(postID)/user",
      completion: { (result: Result<UserResponseDTO, NetworkError>) in
        switch result {
        case .success(let userResponse):
          let user = userResponse.toDomain()
          completion(.success(user))
          return
        case .failure(let error):
          completion(.failure(error))
          return
        }
      })
  }
  
  func updatePost(postID: String, updatedPost: Post, completion: @escaping (Result<Post, Error>) -> Void) {}
  
  func deletePost(postID: String, completion: @escaping (Result<Void, Error>) -> Void) {}
}
