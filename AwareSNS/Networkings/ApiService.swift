import Foundation

class APIService {
    let baseUrl = "https://inui.jn.sfc.keio.ac.jp/aware"
    func fetchPosts(completion: @escaping (Result<[Post], Error>) -> Void) {
        let url = URL(string: baseUrl + "/posts")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode([Post].self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    func sendPost(user_id: String, content: String, completion: @escaping (Result<Success, Error>) -> Void) {
        let url = URL(string: baseUrl + "/send_post?user_id=\(user_id)&content=\(content)")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode(Success.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    func registerUser(user_id: String, user_name: String, completion: @escaping (Result<Success, Error>) -> Void) {
        let url = URL(string: baseUrl + "/register_user?user_id=\(user_id)&user_name=\(user_name)")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode(Success.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}


struct Post: Codable {
    let post_id: String
    let user_id: String
    let user_name: String
    let content: String
    let timestamp: String
}

struct Success: Codable{
    let success: Bool
}
