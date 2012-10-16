$:.unshift(File.expand_path(File.join(File.dirname(__FILE__), "../lib")))
require "eta"

random_title = rand(100000).to_s
process = Eta::Process.new(random_title, "sleep", "3")
process.start

process = Eta::Process.new(random_title, "sleep", "3")
process.start
