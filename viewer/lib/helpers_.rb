# This is the last file loaded!
puts "Cleaning up & generating files..."

# Cleans up autogen'd files
`rm ./../content/category/*`

# Builds categories pages
Category::CATEGORIES.each do |category|
  File.write("./content/category/#{category}", "")
end
