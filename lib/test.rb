require 'rubygems'
require 'rest_client'
require 'json'

result = RestClient.get("http://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20html%20where%20url%3D'http%3A%2F%2Fwww.leighrayment.com%2Fcommons%2FAcommons1.htm'%20and%20xpath%3D%22%2F%2Ftr%22&format=json&diagnostics=false")
values = JSON.parse(result.body)
results = values["query"]["results"]

#results["tr"].each do |table_row|
#  table_row["td"].each

# look for class = xl825803
#end

p results["tr"][13]
