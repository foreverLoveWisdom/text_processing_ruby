# READING WHOLE FILE AT ONCE
# This is simple if wanna read file then do sth else with it(parsing, insert to db...)
File.open("file.txt", "r") do |file|
  contents = file.read
end

# shorter version
contents = File.read("file.txt")

require 'json'
json = File.read("file.json")
data = JSON.parse(json)



# LINE-BY-LINE PROCESSING
# While this solution works, it has a problem.
# Because it reads the whole file at once, it consumes an amount of memory at least equal to the size of the file.
# This will hold up okay for small files, but as our log file grows, so will the memory consumed by our script

File.open('access_log') do |log_file|
  # No need to load all lines into memory here
  requests = log_file.readlines

  requests.each do |request|
    request.start_with?('127.0.0.1') && puts(request)
  end
end



# TREATING FILES AS STREAMS
# The solution is to treat the file as a stream.
# Instead of reading from the beginning of the file to the end in one go, and keeping all of that information in memory, we read only a small amount at a time.
# We might read the first line, for example, then discard it and move onto the second, then discard that and move onto the third, and so on until we reach the end of the file.
# Or we might instead read it character by character, or word by word.
# The important thing is that at no point do we have the full file in memory: we only ever store the little bit that we’re processing
