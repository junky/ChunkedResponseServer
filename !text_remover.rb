require 'digest/md5'

text=File.open(ARGV[0]).read
text = text.gsub(/var VisitorId = ".+";/, 'var VisitorId = "";')
File.new(ARGV[0]+".txt", "w").write(text)
