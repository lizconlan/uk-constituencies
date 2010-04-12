require 'rubygems'
require 'rest_client'
require 'json'

result = RestClient.get("http://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20html%20where%20url%3D'http%3A%2F%2Fwww.leighrayment.com%2Fcommons%2FAcommons3.htm'%20and%20xpath%3D%22%2F%2Ftr%22&format=json&diagnostics=false")
values = JSON.parse(result.body)
results = values["query"]["results"]

def clean_data(input)
  if input.is_a?(Array)
    input = input.join(" ")
  end
  input.strip
end

def is_constituency_start(input)
  return false unless input
  input = clean_data(input)
  if input == input.upcase && 
    input[0..4] != "*****" && 
    input != "THE HOUSE OF COMMONS" &&
    !input.include?("CONSTITUENC") &&
    !input.include?("NAME ") &&
    !input.include?("ALTERED ")
    unless input =~ /\d\d\d\d$/
      return true
    end
  end
  false
end

data = []

constituency = {}
constituency_name = ""

in_constituency = false
member = {}


results["tr"].each do |table_row|
  if table_row["td"][0]["p"].nil? && table_row["td"][1]["p"].nil? && is_constituency_start(table_row["td"][2]["p"])
    p ""
    
    constituency_name = clean_data(table_row["td"][2]["p"])
    p constituency_name
    
    in_constituency = true
    members = []
  elsif in_constituency
    if table_row["td"][0] && table_row["td"][0]["p"] =~ /\d\d\d\d$/
      #initialize member "object"
      member = {:name => nil, :elected_date => nil,:born => nil, :died => nil}
      
      member_name = clean_data(table_row["td"][2]["p"])
      member[:name] = member_name
      
      elected_date = clean_data(table_row["td"][0]["p"])
      member[:elected_date] = elected_date
      
      if table_row["td"][3]["p"]
        member[:born] = table_row["td"][3]["p"]
      end
      if table_row["td"][4]["p"]
        member[:died] = table_row["td"][4]["p"] 
      end
      unless member[:born].nil?
        p member.inspect 
      end
    elsif table_row["td"][0]["p"].nil? && table_row["td"][1]["p"].nil? && table_row["td"][2]["p"]
      if member[:name] && member[:born].nil?
        member_name = clean_data(table_row["td"][2]["p"])
        member[:name] += " " + member_name
        if table_row["td"][3]["p"]
          member[:born] = table_row["td"][3]["p"]
        end
        if table_row["td"][4]["p"]
          member[:died] = table_row["td"][4]["p"] 
        end
        p member.inspect if member[:born]
      end
    end
  end
end
