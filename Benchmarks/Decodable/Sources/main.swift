import Foundation
import Bench
import Decodable

enum JSONError: Swift.Error {
  case typeMismatch
}

extension User.Gender: Decodable {}
extension User.Color: Decodable {}

extension User.Friend: Decodable {

	public static func decode(_ json: Any) throws -> User.Friend {
		return try User.Friend(json: json)
	}

  public init(json: Any) throws {
  	try id = json => "id"
  	try name = json => "name"
  }
}

extension User: Decodable {

	public static func decode(_ json: Any) throws -> User {
		return try User(json: json)
	}
	public init(json: Any) throws {
    	try id  		   = json => "_id"
    	try index  		   = json => "index"
    	try guid 		   = json => "guid"
    	try isActive  	   = json => "isActive"
      	try balance        = json => "balance"	
      	try picture        = json => "picture"	
      	try age            = json => "age"		
      	try eyeColor       = json => "eyeColor"
      	try name           = json => "name"		
      	try gender         = json => "gender"
      	try company        = json => "company"	
      	try email          = json => "email"		
      	try phone          = json => "phone"		
      	try address        = json => "address"	
      	try about          = json => "about"		
      	try registered     = json => "registered"	
      	try latitude       = json => "latitude"	
      	try longitude      = json => "longitude"	
      	try tags           = json => "tags"		
      	try friends = json => "friends"	
      	try greeting       = json => "greeting"	
      	try favoriteFruit  = json => "favoriteFruit"
  }
}


public func run(loop times: Int) -> ([UInt8]) throws -> Void {

  return { input in
    for _ in 0..<times {

      let data = Data(bytes: input)

      _ = try! JSONSerialization.jsonObject(with: data, options: [])
    }
  }
}

let results = try bench(this: run(loop: 1))

describe(benchmark: "Foundation/JSONSerialization(Darwin)", results)

let modelResults = try bench { bytes in
  let data = Data(bytes: bytes)

  let json = try JSONSerialization.jsonObject(with: data)
  _ = try [User].decode(json)
}

describe(benchmark: "Foundation/JSONSerialization(Darwin) Model", modelResults)

let singleModelResults = try bench(times: 100, using: "single") { bytes in
  let data = Data(bytes: bytes)

  let json: Any = try JSONSerialization.jsonObject(with: data)
  _ = try User.decode(json)
}

describe(benchmark: "Foundation/JSONSerialization(Darwin) Single Model", singleModelResults)

