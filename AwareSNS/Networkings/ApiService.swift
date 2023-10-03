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
    
    func fetchReplies(post_id: String, completion: @escaping (Result<[Reply], Error>) -> Void) {
        let url = URL(string: baseUrl + "/replies?post_id=\(post_id)")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode([Reply].self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    func getEmotion(user_id: String, completion: @escaping (Result<Emotion, Error>) -> Void) {
        let url = URL(string: baseUrl + "/get_emotion?user_id=\(user_id)")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode(Emotion.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    func sendPost(user_id: String, content: String, emotion: String, completion: @escaping (Result<Success, Error>) -> Void) {
        let url = URL(string: baseUrl + "/send_post?user_id=\(user_id)&content=\(content)&emotion=\(emotion)")!
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
    
    func sendReply(post_id: String, user_id: String, content: String, completion: @escaping (Result<Success, Error>) -> Void) {
        let url = URL(string: baseUrl + "/send_reply?post_id=\(post_id)&user_id=\(user_id)&content=\(content)")!
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
    
    func SignIn(user_id: String, user_name: String, password: String, completion: @escaping (Result<Success, Error>) -> Void) {
        let url = URL(string: baseUrl + "/sign_in?user_id=\(user_id)&user_name=\(user_name)&password=\(password)")!
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
    
    func LogIn(user_id: String, password: String, completion: @escaping (Result<Success, Error>) -> Void) {
        let url = URL(string: baseUrl + "/log_in?user_id=\(user_id)&password=\(password)")!
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
    
    func isUserRegistered(user_id: String, completion: @escaping (Result<Success, Error>) -> Void) {
        let url = URL(string: baseUrl + "/is_user_registered?user_id=\(user_id)")!
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
    
    func fetchUser(user_id: String, completion: @escaping (Result<User, Error>) -> Void) {
        let url = URL(string: baseUrl + "/user?user_id=\(user_id)")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode(User.self, from: data)
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
    let emotion: String
    let timestamp: String
    let reply_count: Int
}

struct Reply: Codable {
    let reply_id: String
    let post_id: String
    let user_id: String
    let user_name: String
    let content: String
    let timestamp: String
}

struct Success: Codable{
    let success: Bool
}

struct Emotion: Codable{
    let emotion: String
}

struct User: Codable{
    let user_id: String
    let user_name: String
}
