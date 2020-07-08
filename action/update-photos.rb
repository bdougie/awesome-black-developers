#!/usr/bin/env ruby
#/ Usage: ./action/update-photos 
#/ Update the local README photo wall to reflect the current developers listed in
# bdougie/awesome-black-developers.

require "httparty"
require "json"

developers = %w(
  aprilspeight
  bdougie
  dayhaysoos
  ifiokjr
  kjaymiller
  m0nica
  Prophen
)

def build_photo_grid(users)
  lines = []

  users.each_slice(8) do |slice|
    header = slice.map { |e| handle_link(e) }.join(" | ").strip
    delimiter = slice.map { |e| "---" }.join(" | ")
    row = slice.map { |e| photo_link(e) }.join(" | ").strip

    lines += [header, delimiter, row, ""]
  end

  lines.join("\n")
end

def handle_link(login)
  "[@#{login}](https://github.com/#{login})"
end

def photo_link(login)
  "![@#{login}](https://avatars.githubusercontent.com/#{login}?s=100&v=1)"
end

puts "Action succesfully ran"

puts "-------------------------------------------------"
print build_photo_grid(developers)
puts "-------------------------------------------------"
