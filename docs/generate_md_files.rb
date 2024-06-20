require 'fileutils'

# Define the directories
photos_dir = 'assets/images/gallery/photos'
output_dir = '_exhibits'

# Create the output directory if it doesn't exist
FileUtils.mkdir_p(output_dir)

# Read all image files from the photos directory
photos = Dir.entries(photos_dir).select { |f| File.file?(File.join(photos_dir, f)) && f =~ /\.(png|jpg|jpeg|gif)$/i }

# Define the default content for the markdown files
layout = 'exhibit'
description = 'description'
width_type = 'medium'

# Generate a .md file for each photo
photos.each do |photo|
  title = File.basename(photo, '.*').gsub('-', ' ').capitalize
  filename = "#{File.basename(photo, '.*')}.md"
  filepath = File.join(output_dir, filename)
  
  content = <<-MD
---
layout: #{layout}
title: "#{title}"
description: "#{description}"
width_type: #{width_type}
---
MD

  # Write the content to the .md file
  File.write(filepath, content)
end

puts "Generated #{photos.length} .md files in #{output_dir}."
