GFILE = "Gemfile.lock"

list = File.read(GFILE)

gems = []

list.each_line do |line|
  line = line.strip
  break if line.include?("PLATFORMS")
  next if line.include?("GEM")
  next if line.include?("remote:")
  next if line.include?("specs:")
  next if line.empty?
  gems.push(line.split(' ').first)
end

total = 0
gems.uniq!
gems.each do |gem|
  puts "Processing #{gem}"
  contents = `gem contents #{gem}`.split
  local = 0
  contents.each do |file|
    output = `wc -l #{file}`
    amount = output.strip.split(' ').first.to_i
    local += amount
  end
  puts "  LOC: #{local}"
  total += local
end

puts "Total Lines: #{total}"

