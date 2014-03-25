size = File.size(ARGV[0])
File.rename(ARGV[0], size.to_s + "-"+ ARGV[0])