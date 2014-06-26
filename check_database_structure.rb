ActiveRecord::Base.connection.tables.each do |table_name|
  puts "\n" + table_name
  ActiveRecord::Base.connection.columns(table_name).each {|c| puts "- " + c.name + ": " + c.type.to_s + " " + c.limit.to_s}
end