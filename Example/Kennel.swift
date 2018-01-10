import Foundation
import ObjectMapper
import Realm
import RealmSwift

class Kennel: Object, Mappable {
  @objc dynamic var id: Int = 0
  @objc dynamic var name: String = ""
  @objc dynamic var dogs: [Dog]?

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
    dogs <- map["dogs"]
  }
}

