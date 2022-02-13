if Gem.win_platform?
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end
require_relative 'post'
require_relative 'memo'
require_relative 'task'
require_relative 'link'
require "sqlite3"

puts "****** Я БЛОКНОТ ******"
puts "Что желаете записать?"

choices = Post.post_types.keys

choice = -1

until  choice >=0 && choice < choices.size

  choices.each_with_index do |type, index|
    puts "\t #{index}. #{type}"
  end
  choice = STDIN.gets.chomp.to_i
end

entry = Post.create(choices[choice])

entry.read_from_console

id = entry.save_to_db

puts " ЗАПИСЬ СОХРАНЕНА, id = #{id}"