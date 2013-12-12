#!/usr/bin/ruby

require 'fileutils'
require 'optparse'
require 'json'

options = {}
options[:debug]=false
options[:decrypt]=false

OptionParser.new do |opts|
  opts.banner = 'here is help messages of the command line tool.'
  opts.on('-i DirOrFile', '--in DirOrFile', 'Source DirOrFile') do |value|
    options[:input]=value
  end
  opts.on('-o DirOrFile', '--out DirOrFile', 'Output DirOrFile') do |value|
    options[:output]=value
  end
  opts.on('-D', '--decrypt', 'decrypt action') do
    options[:decrypt]=true
  end
  opts.on('-p', '--pass', 'encrypt or decrypt password') do |value|
    options[:password]=value
  end
  opts.on('-d', '--debug', 'debug mode') do
    options[:debug]=true
  end
end.parse!

if File.exist?('config.json')
  cfg_file = File.open('config.json')
  config =  JSON.parse(cfg_file.read)
  cfg_file.close
end

if config.class == Hash
  OPENSSL_BIN=config['openssl']
  ENCRYPT_METHOD=config['method']
else
  OPENSSL_BIN="openssl"
  ENCRYPT_METHOD="-aes-256-cbc"
end

SOURCE_DIR=options[:input]
OUTPUT_DIR=options[:output]
DEBUG_FLAG=options[:debug]
DECRYPT_FLAG=options[:decrypt]
if options[:password]==nil
  puts "input encrypt or decrypt password:"
  PASSWORD = gets.chomp
else
  PASSWORD=options[:password]
end

ENCRYPT_ACTION = if DECRYPT_FLAG then "decrypt" else "encrypt" end

if SOURCE_DIR==nil or OUTPUT_DIR==nil
  puts "Error:need Source DirOrFile and Output DirOrFile"
  exit(1)
end
if DEBUG_FLAG
	puts "input:#{SOURCE_DIR}"
	puts "output:#{OUTPUT_DIR}"
	puts "encrypt method:#{ENCRYPT_METHOD}"
    puts "action:#{ENCRYPT_ACTION}"
end

def traverse_dir(file_path)
  if File.directory? file_path
    Dir.foreach(file_path) { |file|
      if file!="." and file!=".."
        traverse_dir(file_path+"/"+file){|x| yield x}
      end
    }
  else
    yield  file_path
  end
end


def getDirFileCount(file_patch)
  num = 0
  traverse_dir(file_patch) { |x|
    num += 1
  }
  num
end

allFileCount = getDirFileCount(SOURCE_DIR)

item_index = 1
traverse_dir(SOURCE_DIR) { |onefile|
	if DECRYPT_FLAG
	  onefile2 = onefile.sub(SOURCE_DIR,OUTPUT_DIR)
	  onefile2 = onefile2[0..-5]
	else
	  onefile2 = onefile.sub(SOURCE_DIR,OUTPUT_DIR) + ".aes"
	end	
	onefile2_dir = File.dirname(onefile2)
	if not Dir.exist?(onefile2_dir)
		puts "#{onefile2_dir} is not exist,mkdir it" if DEBUG_FLAG
		FileUtils.mkdir_p(onefile2_dir)
	end
   crypt_cmd = "#{OPENSSL_BIN} enc #{ENCRYPT_METHOD} -in \"#{onefile}\" -out \"#{onefile2}\" -k #{PASSWORD}"
   if DECRYPT_FLAG then crypt_cmd += " -d" end
	#puts crypt_cmd
	if system(crypt_cmd)
		puts "#{item_index}/#{allFileCount} AES #{ENCRYPT_ACTION} #{onefile} ok"
	else
		puts "#{item_index}/#{allFileCount} AES #{ENCRYPT_ACTION} #{onefile} fail"
	end
	item_index += 1
}
