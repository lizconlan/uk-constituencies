require '../db/db_helper'
require 'rubygems'
require 'fastercsv'
require 'json'
require 'rest_client'

def get_uuid
  # result = RestClient.get("#{DBSERVER}/_uuids")
  # values = JSON.parse(result.body)
  # values["uuids"].first
  `uuidgen`.strip
end

line_count = 1

FasterCSV.foreach("../data/constituencies.txt") do |row|
  unless line_count == 1
    name = row[0].gsub("\"", "").strip
    year_created = row[1].strip
    if row[2]
      year_abolished = row[2].strip
    else
      year_abolished = ""
    end
    if row[3]
      alt_name = row[3].gsub("\"", "").strip
    else
      alt_name = ""
    end
    
    constituency = {"name" => "#{name}", "created" => "#{year_created}", "abolished" => "#{year_abolished}", "alternative_name" => "#{alt_name}"}
    p "#{name} = #{year_created}"
    uuid = get_uuid()

    doc = <<-JSON
    #{JSON.generate(constituency)}
    JSON

    RestClient.put("#{DATABASE}/#{uuid}", doc)
  end
  
  line_count += 1  
end