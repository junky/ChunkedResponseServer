require 'digest/md5'

hash_prefix = Digest::MD5.file(ARGV[0]).to_s[0,8]
File.rename(ARGV[0], hash_prefix + "-"+ ARGV[0])