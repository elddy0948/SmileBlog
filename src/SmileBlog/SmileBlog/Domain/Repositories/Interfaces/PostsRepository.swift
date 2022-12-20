import Foundation

protocol PostsRepository {
  func create(post: Post, completion: @escaping (Result<Post, Error>) -> Void)
  func fetchPost(postID: String, completion: @escaping (Result<Post, Error>) -> Void)
  func fetchPosts(completion: @escaping (Result<[Post], Error>) -> Void)
  func fetchPostsUser(postID: String, completion: @escaping (Result<User, Error>) -> Void)
  func updatePost(postID: String, updatedPost: Post, completion: @escaping (Result<Post, Error>) -> Void)
  func deletePost(postID: String, completion: @escaping (Result<Void, Error>) -> Void)
}
