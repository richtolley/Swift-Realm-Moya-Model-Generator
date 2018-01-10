require 'json'

class SwiftModelGenerator 

  def generateModels(json)
    json.each_pair { |name, val| create_model(name,val) }
  end

  def add_default_constructors(useRealm, useMoyaObjectMapper, text_result) 
	text_result << "  required init?(map: Map) { super.init() }\n\n"

	text_result << "  required init() {\n"
	text_result << "    super.init()\n"
	text_result << "  }\n\n"

	text_result << "  required init(value: Any, schema: RLMSchema) {\n"
	text_result << "    super.init(value: value, schema: schema)\n"
	text_result << "  }\n\n"

	text_result << "  required init(realm: RLMRealm, schema: RLMObjectSchema) {\n"
	text_result << "    super.init(realm: realm, schema: schema)\n"
	text_result << "  }\n"

	text_result
  end

  def infer_default_value(typename) 
	return "" if typename.length == 0 || typename[-1] == "?"

	case typename
	when "Int"
	  " = 0"
	when "String"
	  " = \"\""
	when "Double"
	  " = 0.0"
	when "Float"
	  " = 0.0"
	when "CGFloat"
	  " = 0.0"
	when "Bool"
	  " = false"
	else
	  ""
    end
  end


  def create_model(name, json) 
	text_result = ""
	text_result << "import Foundation\n"
	text_result << "import ObjectMapper\n"
	text_result << "import Realm\n"
	text_result << "import RealmSwift\n"

	text_result << "\n"
	text_result << "class #{name.capitalize}: Object, Mappable {\n"

	json.each_pair { |k,v| text_result << "  @objc dynamic var #{k}: #{v}#{infer_default_value(v)}\n" }

	text_result << "\n"

	text_result = add_default_constructors(true, true, text_result)

	if json.keys.include?("id")
	  text_result << "\n"
      text_result << "  override class func primaryKey() -> String? {\n"
      text_result << "    return \"id\"\n"
      text_result << "  }\n"
	end


	text_result << "\n"

	text_result << "  func mapping(map: Map) {\n"

	json.each_pair { |k,v| text_result << "    #{k} <- map[\"#{k}\"]\n" }

	text_result << "  }\n"
	text_result << "}\n"
	text_result << "\n"

	out_file = File.open("Results/#{name.capitalize}.swift","w")
	out_file.write text_result 
  end
end

json_file_path = ARGV[0]
gen = SwiftModelGenerator.new

if json_file_path.length > 0 
  in_file = File.open(json_file_path,"r")
  lines = in_file.read
  json = JSON.parse(lines) 
  gen = SwiftModelGenerator.new
  gen.generateModels(json)
  
end



