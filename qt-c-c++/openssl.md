### QT使用openssl

```bash
#pro文件添加
#openssl 
INCLUDEPATH+=/usr/local/opt/openssl@1.1/include
LIBS+=-L/usr/local/opt/openssl@1.1/lib -lssl -lcrypto
```

### md5码：单性加密

​	unsigned char *MD5(const unsigned char *d, size_t n, unsigned char *md);
​	d 输入的数据，n数据的长度，md返回的md5码。
​	返回：md5码

```c++
//例：
#include<openssl/ssl.h>
#include<openssl/md5.h>
#include<iostream>
int main(){
	char strs[]="我是安忍的小学生";
    unsigned char md5_str[32]={0};
    MD5((const unsigned char *)strs,strlen(strs),md5_str);
    for(int i=0;i<32;i++){
        printf("%X",*(md5_str[i]));
    }
	}
//sha256 哈希：
char strs[]="我是安忍的小学生";
unsigned char hash[64]={0};
SHA256(( const unsigned char *) strs,strlen(strs),(unsigned char *)hash);
for(int i=0;i<=64;i++){
     printf("%X.",*(hash+i));
}
```

### DES	对称加密：

```c++
#include<openssl/ssl.h>
#include<openssl/des.h>
#include<iostream>
#include<string>
int main()
{
  	char key_chars[8]={"woshish"};
	//key char[8];
	DES_cblock key;
	memset(key,0,8);
	memcpy(key,key_chars,8);
	//des秘密结构体
	DES_key_schedule keyschedule;
	//把8位的char输入到秘密结构体中。
	DES_set_key_unchecked(&key,&keyschedule);
	//加密的数据部分
	char data[]="asdfasdfadsfadsfasdfasdfasdfsdfksaidfiasdfiasjf";
	//加密后的数据部分。
	char dec_data[sizeof (data)];
	//8位的输入块 typedef unsigned char DES_cblock[8];
	const_DES_cblock bio_dom;
	//8位的输出 typedef unsigned char const_DES_cblock[8];
	DES_cblock outputText;
	for(int i=0;i<sizeof (data)/8;i++){
    	//复制加密的8位数据到const_DES_cblock
    	memcpy(bio_dom,data+(i*8),8);
    	//加密
    	DES_ecb_encrypt(&bio_dom,&outputText,&keyschedule,DES_ENCRYPT);
        	//参数1 加密的数据8位
        	//参数2 加密后的数据8位。
        	//参数3 加密时的秘密结构体。
        	//参数4 加密还是解密。
            	//DES_ENCRYPT     1 加密
            	//DES_DECRYPT     0 解密
    	memcpy(dec_data+(i*8),outputText,8);
	}
	//输出测试。
	dec_data[48]='\0';
	qDebug()<<dec_data;
	//解密部分：
	memset(data,0,sizeof (data));
	for(int i=0;i<sizeof (dec_data)/8;i++){
    	//复制解密的8位数据到const_DES_cblock
   	 memcpy(bio_dom,dec_data+(i*8),8);
    	//解密
    	DES_ecb_encrypt(&bio_dom,&outputText,&keyschedule,DES_DECRYPT);
        	//参数1 加密的数据8位
        	//参数2 加密后的数据8位。
        	//参数3 加密时的秘密结构体。
       	 	//参数4 加密还是解密。
            	//DES_ENCRYPT     1 加密
            	//DES_DECRYPT     0 解密
    	memcpy(data+(i*8),outputText,8);
	}
	qDebug()<<data;
	}
```

### rsa非对称加密

```c++
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QDebug>
//#include<openssl/des.h>
#include<openssl/rsa.h>
#include<openssl/ssl.h>
int main(){
    //密钥，公钥部分
    std::string strKey[2]; //最后存公钥和私钥。
    int key_length=2048;    //  密钥长度
    char pub_key_file[]="./pubkey.pem";   //公钥名称。
    char pri_key_file[]="./prikey.pem";   //私钥名称。
    char *pri_key=nullptr;
    char *pub_key=nullptr;
    size_t pri_len=0,pub_len=0;
//    struct rsa_st RSA 结构体
    RSA *keypair= RSA_generate_key(key_length,RSA_3,NULL,NULL);
    BIO *pri=BIO_new(BIO_s_mem());
    BIO *pub=BIO_new(BIO_s_mem());
    //
//    绑定管道
    PEM_write_bio_RSAPrivateKey(pri,keypair,NULL,NULL,0,NULL,NULL);
    PEM_write_bio_RSAPublicKey(pub,keypair);
    //取公钥 私药的长度。
    pri_len=BIO_pending(pri);
    pub_len=BIO_pending(pub);
    //用来存私钥和公钥的指针。
    pri_key=(char *)malloc(pri_len+1);
    pub_key=(char *)malloc(pub_len+1);
    //从私钥管道中读取私钥
    BIO_read(pri,pri_key,pri_len);
    //从公药管道中读取公钥。
    BIO_read(pub,pub_key,pub_len);
    //字符串结束符。
    pri_key[pri_len]='\0';
    pub_key[pub_len]='\0';
    strKey[0]=pub_key;
    strKey[1]=pri_key;

//    FILE *pubFile=fopen(pub_key_file,"w");
//    if(pubFile==NULL){
//        qDebug()<<"pub file open error";
//        assert(false);
//        exit(-1);
//    };
//    qDebug()<<pub_key;
//    fputs(pub_key,pubFile);
//    fclose(pubFile);
//    FILE *priFILE=fopen(pri_key_file,"w");
//    if(priFILE==nullptr){
//        assert(false);
//        exit(-1);
//    }
//    fputs(pub_key,priFILE);
//    fclose(priFILE);
//    qDebug()<<strKey[0].data()<<strKey[1].data();
    //公钥加密
    char data[]="我是测试数据。";
    RSA *rsa=nullptr;
    BIO *keybio=BIO_new_mem_buf(pub_key,-1);
    //new 一个新的RSA
    RSA *pRSAPublicKey=RSA_new();
    //用public BIO创建rsa
    rsa=PEM_read_bio_RSAPublicKey(keybio,&rsa,NULL,NULL);
    //创建输出buff.
    char *out=(char *)malloc(RSA_size(rsa));
    //加密
    int ret= RSA_public_encrypt(sizeof (data),(const unsigned char*)data,(unsigned char*)out,rsa,RSA_PKCS1_PADDING);
    qDebug()<<out;
    BIO_free_all(keybio);
    //私钥解密
    keybio=BIO_new_mem_buf(pri_key,-1);
    rsa=PEM_read_bio_RSAPrivateKey(keybio,&rsa,NULL,NULL);
    int len=RSA_size(rsa);
    char *data_in=out;
    out=(char *)malloc(len+1);
    ret =RSA_private_decrypt(len,(unsigned char*)data_in,(unsigned char*)out,rsa,RSA_PKCS1_PADDING);
    BIO_free_all(keybio);
//    qDebug()<<out;
};
```


	