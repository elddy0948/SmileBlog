import Foundation

final class DefaultPostsUseCase {
  private let postsRepository: PostsRepository
  
  init(postsRepository: PostsRepository) {
    self.postsRepository = postsRepository
  }
  
  func create(post: Post, completion: @escaping (Result<Post, Error>) -> Void) {
    postsRepository.create(post: post, completion: { result in
      switch result {
      case .success(let post):
        completion(.success(post))
        return
      case .failure(let error):
        completion(.failure(error))
        return
      }
    })
  }
  
  func fetchPost(postID: String, completion: @escaping (Result<Post, Error>) -> Void) {
    postsRepository.fetchPost(postID: postID, completion: { result in
      switch result {
      case .success(let post):
        completion(.success(post))
        return
      case .failure(let error):
        completion(.failure(error))
        return
      }
    })
  }
  
  func fetchPosts(completion: @escaping (Result<[Post], Error>) -> Void) {
    postsRepository.fetchPosts(completion: { result in
      switch result {
      case .success(let posts):
        completion(.success(posts))
        return
      case .failure(let error):
        completion(.failure(error))
        return
      }
    })
  }
  
  func fetchPostsUser(postID: String, completion: @escaping (Result<User, Error>) -> Void) {
    postsRepository.fetchPostsUser(postID: postID, completion: { result in
      switch result {
      case .success(let user):
        completion(.success(user))
        return
      case .failure(let error):
        completion(.failure(error))
        return
      }
    })
  }
  
  func updatePost(postID: String, updatedPost: Post, completion: @escaping (Result<Post, Error>) -> Void) {
    postsRepository.updatePost(postID: postID, updatedPost: updatedPost, completion: { result in
      switch result {
      case .success(let post):
        completion(.success(post))
        return
      case .failure(let error):
        completion(.failure(error))
        return
      }
    })
  }
  
  func deletePost(postID: String, completion: @escaping (Result<Void, Error>) -> Void) {
    postsRepository.deletePost(postID: postID, completion: { result in
      switch result {
      case .success(_):
        completion(.success(()))
      case .failure(let error):
        completion(.failure(error))
      }
    })
  }
}
