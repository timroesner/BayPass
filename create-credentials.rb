#!/usr/bin/ruby

file_content = <<-CREDS_FILE_STRING
import Foundation

struct Credentials {
   let birdToken = "#{ENV['BIRD_TOKEN']}"
   let bartToken = "#{ENV['BART_TOKEN']}"
   let googleDirections = "#{ENV['GOOGLE_DIRECTIONS']}"
   let multicycles = "#{ENV['MULTICYCLES']}"
}
CREDS_FILE_STRING
file = File.new("./BayPass/APIs/Credentials.swift", "w")
file.puts(file_content)
file.close
