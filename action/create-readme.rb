#!/usr/bin/env ruby
#/ Usage: ./action/update-photos
#/ Update the local README photo wall to reflect the current developers listed in
# bdougie/awesome-black-developers.
require "yaml"

class Readme
  DEFAULT_README = "README.md"

  def initialize(filename: DEFAULT_README)
    @filename = filename
    @developers = read_developer_yaml.merge(read_temp_file)
  end

  def read_developer_yaml
    file = File.open('developers.yaml')
    file_data = file.read
    file.close
    YAML::load(file_data)
  end

  def read_temp_file
    file = File.open('temp.txt')
    handle = ""
    links = []
    file_data = file.readlines.each_with_index.map do |line, index|
      if index == 0
        handle =line.gsub("#", "").strip
      else
        if !line.nil? && !line.strip.empty?
          links.push(line.gsub("*", "").strip)
        end
      end
    end
    {handle => links}
  end

  def update_developer_yaml
    yaml = @developers.to_yaml
    File.write('developers.yaml', yaml)
  end

  def preview
    [
      "# Awesome Black Developers [![Awesome](https://awesome.re/badge.svg)](https://awesome.re)",
      "> Talks, blog posts, and interviews amplifying the voices of Black developers on GitHub because #BlackLivesMatter",
      build_photo_grid(@developers),
      build_developer_list(@developers),
      "## 💅🏾 Contributing",
      "Additional suggestions are welcomed! Check out [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.",
      "(NOTE: If you're a developer listed on here who would like to be removed, just open an issue or message me privately.)",
      "## 📖 License and attribution
      This list is available under the Creative Commons CC0 1.0 License, meaning you are free to use it for any purpose, commercial or non-commercial, without any attribution back to me (public domain). (If you ever want to reference me, find me here! [@bdougieYO](http://twitter.com/bdougieYO) But you are in no way required to do so.)"
    ].join("\n\n")
  end

  def save!
    update_developer_yaml
    File.write(@filename, preview)
  end
end

def build_photo_grid(users)
  lines = []

  users.map{|k, v| k}.each_slice(8) do |slice|
    header = slice.map { |e| handle_link(e) }.join(" | ").strip
    delimiter = slice.map { |e| "---" }.join(" | ")
    row = slice.map { |e| photo_link(e) }.join(" | ").strip

    lines += [header, delimiter, row, ""]
  end

  lines.join("\n")
end

def build_developer_list(users)
  row = users.map do |handle, links|
    developer_row = []
    developer_row.push("### [@#{handle}](https://github.com/#{handle})")
    links.each do |link|
      developer_row.push(" * #{link}")
    end
    developer_row.join("\n")
  end
  row.join("\n\n")
end

def handle_link(login)
  "[@#{login}](#{login})"
end

def photo_link(login)
  "![@#{login}](https://avatars.githubusercontent.com/#{login}?s=100&v=1)"
end

def update_readme(save: false)
  readme = Readme.new
  save ? readme.save! : (puts readme.preview)
end

update_readme(save: true)
