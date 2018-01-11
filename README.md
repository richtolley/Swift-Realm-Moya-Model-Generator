# Swift Realm/Moya Model Generator

Simple script for automating the creation of Swift model layer classes using [Moya-ObjectMapper](https://github.com/ivanbruel/Moya-ObjectMapper) and [Realm Swift](https://realm.io/docs/swift/latest). These libraries provide a straightforward, clean object persistence/JSON mapping solution, replacing standard iOS libraries such as Core Data and `NSJSONSerialization`. 

However, neither Realm nor Moya provide an easy way of automatically generating model classes. This script takes a json file specifying entity names and types, and generates a series of pure Swift model classes. It is very bare-bones but may be extended if it proves useful.

## Description
Given an input json file, the script creates a series of model files in the 'Results' directory. The file should contain a root-level JSON dictionary, each sub-dictionary of which describes a model object. Sub dictionaries specify type names as keys and types as values:

#### test.json:
```json
{
  "Cat" : {
    "id" : "Int",
    "name" : "String",
    "color" : "String?",
    "age" : "Int"
  },
  "Dog" : {
    "id" : "Int",
    "name" : "String",
    "color" : "String",
    "age" : "Double"
  },
  "Kennel" : {
    "id" : "Int",
    "name": "String",
    "dogs": "[Dog]?"
  },
  "Cattery" : {
    "id" : "Int",
    "name": "String",
    "cats": "[Cat]?"
  }
}
```

This produces 4 files - an example is:

```swift
import Foundation
import ObjectMapper
import Realm
import RealmSwift

class Cat: Object, Mappable {
  @objc dynamic var id: Int = 0
  @objc dynamic var name: String = ""
  @objc dynamic var color: String?
  @objc dynamic var age: Int = 0

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
  }
}
```

This file is included in the repository for demo purposes.

## Usage
To create the model objects, simply run:

```sh
$ ruby generator.rb $PATH_TO_JSON_SPEC_FILE
```

The generated files should appear in the Results folder

## TODO 
- make Realm/Moya library inclusion optional
- improve default type inference
 

Written in Ruby 2.0
