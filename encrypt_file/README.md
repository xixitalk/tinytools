## 简介
利用openssl对文件夹进行对称加密（如AES）和解密ruby脚本

## 目的
本地保护文件或者保护上传到云空间的文件

## 命令用法
* -i, --in DirOrFile               Source DirOrFile
* -o, --out DirOrFile              Output DirOrFile
* -D, --decrypt                    decrypt action
* -p, --pass                       encrypt or decrypt password
* -d, --debug                      debug mode

Source DirOrFile:对于加密是明文文件目录，对于解密是加密文件目录。Output DirOrFile同理相反。  
-D 是执行解密操作，默认是执行加密操作。  
-p 命令中代入加密或者解密密码  

## 配置config.json
可以用config.json来修改配置信息  
* openssl 配置openssl命令
* method  配置加解密算法
* suffix  加密文件后附加的后缀名

## 支持的加解密算法
config.json里`method`可以配置加密算法  
openssl支持的加解密算法都可以，列举如下算法：
* base64             Base 64
* bf-cbc             Blowfish in CBC mode
* bf                 Alias for bf-cbc
* bf-cfb             Blowfish in CFB mode
* bf-ecb             Blowfish in ECB mode
* bf-ofb             Blowfish in OFB mode
* cast-cbc           CAST in CBC mode
* cast               Alias for cast-cbc
* cast5-cbc          CAST5 in CBC mode
* cast5-cfb          CAST5 in CFB mode
* cast5-ecb          CAST5 in ECB mode
* cast5-ofb          CAST5 in OFB mode
* des-cbc            DES in CBC mode
* des                Alias for des-cbc
* des-cfb            DES in CBC mode
* des-ofb            DES in OFB mode
* des-ecb            DES in ECB mode
* des-ede-cbc        Two key triple DES EDE in CBC mode
* des-ede            Two key triple DES EDE in ECB mode
* des-ede-cfb        Two key triple DES EDE in CFB mode
* des-ede-ofb        Two key triple DES EDE in OFB mode
* des-ede3-cbc       Three key triple DES EDE in CBC mode
* des-ede3           Three key triple DES EDE in ECB mode
* des3               Alias for des-ede3-cbc
* des-ede3-cfb       Three key triple DES EDE CFB mode
* des-ede3-ofb       Three key triple DES EDE in OFB mode
* desx               DESX algorithm.
* gost89             GOST 28147-89 in CFB mode (provided by ccgost engine)
* gost89-cnt        `GOST 28147-89 in CNT mode (provided by ccgost engine)
* idea-cbc           IDEA algorithm in CBC mode
* idea               same as idea-cbc
* idea-cfb           IDEA in CFB mode
* idea-ecb           IDEA in ECB mode
* idea-ofb           IDEA in OFB mode
* rc2-cbc            128 bit RC2 in CBC mode
* rc2                Alias for rc2-cbc
* rc2-cfb            128 bit RC2 in CFB mode
* rc2-ecb            128 bit RC2 in ECB mode
* rc2-ofb            128 bit RC2 in OFB mode
* rc2-64-cbc         64 bit RC2 in CBC mode
* rc2-40-cbc         40 bit RC2 in CBC mode
* rc4                128 bit RC4
* rc4-64             64 bit RC4
* rc4-40             40 bit RC4
* rc5-cbc            RC5 cipher in CBC mode
* rc5                Alias for rc5-cbc
* rc5-cfb            RC5 cipher in CFB mode
* rc5-ecb            RC5 cipher in ECB mode
* rc5-ofb            RC5 cipher in OFB mode
* aes-[128|192|256]-cbc  128/192/256 bit AES in CBC mode
* aes-[128|192|256]      Alias for aes-[128|192|256]-cbc
* aes-[128|192|256]-cfb  128/192/256 bit AES in 128 bit CFB mode
* aes-[128|192|256]-cfb1 128/192/256 bit AES in 1 bit CFB mode
* aes-[128|192|256]-cfb8 128/192/256 bit AES in 8 bit CFB mode
* aes-[128|192|256]-ecb  128/192/256 bit AES in ECB mode
* aes-[128|192|256]-ofb  128/192/256 bit AES in OFB mode

## windows平台
windows平台可以使用自带的openssl.exe，方法是用config.json.win32覆盖config.json。

## 使用举例
加密：encrypt_file.rb -i src -o dest  
解密：encrypt_file.rb -i dest -o src2 -D
