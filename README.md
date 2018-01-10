# Swift Realm/Moya Model Generator

Simple script for automating the creation of Swift model layer classes using [Moya-ObjectMapper](https://github.com/ivanbruel/Moya-ObjectMapper) and [Realm Swift](https://realm.io/docs/swift/latest). These libraries provide a straightforward, clean object persistence/JSON mapping solution, replacing standard iOS libraries such as Core Data and `NSJSONSerialization`. 

However, neither Realm nor Moya provide an easy way of automatically generating model classes. This script takes a json file specifying entity names and types, and generates a series of pure Swift model classes. It is very bare-bones but may be extended if it proves useful.

## Description
Given an input json file, the script creates a series of model files in the 'Results' directory. The file should contain a root-level JSON dictionary, each sub-dictionary of which describes a model object. Sub dictionaries specify type names as keys and types as values. 

#### test.json:
```sh
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

This file is included in the repository for demo purposes.

## Usage
To create the model objects, simply run:

```sh
$ ruby generator.rb $PATH_TO_JSON_SPEC_FILE
```

## TODO 
- make Realm/Moya library inclusion optional
- improve default type inference
 

Written in Ruby 2.0
