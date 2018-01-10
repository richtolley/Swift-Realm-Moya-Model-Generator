import Foundation
import ObjectMapper
import Realm
import RealmSwift

class Dog: Object, Mappable {
  @objc dynamic var id: Int = 0
  @objc dynamic var name: String = ""
  @objc dynamic var color: String = ""
  @objc dynamic var age: Double = 0.0
  @objc dynamic var neutered: Bool = false

  required init?(map: Map) { super.init() }

  required init() {
    super.init()
  }

  required init(value: Any, schema: RLMSchema) {
    super.init(value: value, schema: schema)
  }

  required init(realm: RLMRealm, schema: RLMObjectSchema) {
    super.init(realm: realm, schema: schema)
  }

  override class func primaryKey() -> String? {
    return "id"
  }

  func mapping(map: Map) {
    id <- map["id"]
    name <- map["name"]
    color <- map["color"]
    age <- map["age"]
    neutered <- map["neutered"]
  }
}

