require 'digest/md5'

f=File.open(ARGV[0])
text = f.read
f.close

text = text.gsub(/var VisitorId = ".+";/, 'var VisitorId = "";')
prefix = "0"
if text.include?('<a href="{{productUrl}}">View Details &raquo;</a>')
    prefix = "1"
end;

File.rename(ARGV[0], prefix + "-"+ ARGV[0])
