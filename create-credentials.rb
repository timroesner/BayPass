#!/usr/bin/ruby

file_content = <<-CREDS_FILE_STRING
import Foundation

struct Credentials {
    let birdToken = "#{ENV['BIRD_TOKEN']}"
}
CREDS_FILE_STRING
print("Created File content")
file = File.new("./BayPass/APIs/Credentials.swift", "w")
file.puts(file_content)
file.close
print("Wrote File")
