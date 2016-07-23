#include <stdio.h>
#include <openssl/ssl.h>
#include <openssl/err.h>
#include <openssl/bio.h>

#define APIKEY "YzUwYzQ3MzAzODdlZDJlYjUxMmZiYzk0NTc5ZjVlNTM1YzY3MjFjMjI5MDI5MDQzMzRlNDA1ODJkMmE1M2ExMQ=="
#define HOST "wimi-test.herokuapp.com"
#define PORT "443"

int main() {

	//
	//	Initialize Variables
	//
	BIO* bio;
	SSL* ssl;
	SSL_CTX* ctx;

	//
	//   Registers the available SSL/TLS ciphers and digests.
	//
	//   Basically start the security layer.
	//
	SSL_library_init();

	//
	//	Creates a new SSL_CTX object as framework to establish TLS/SSL
	//	or DTLS enabled connections
	//
	ctx = SSL_CTX_new(SSLv23_client_method());

	//
	//	-> Error check
	//
	if (ctx == NULL)
	{
		printf("Ctx is null\n");
	}

	//
	//	 Creates a new BIO chain consisting of an SSL BIO
	//
	bio = BIO_new_ssl_connect(ctx);

	//
	//	uses the string name to set the hostname
	//
	BIO_set_conn_hostname(bio, HOST ":" PORT);

	//
	//	 Attempts to connect the supplied BIO
	//
	if(BIO_do_connect(bio) <= 0)
	{
		printf("Failed connection\n");
		return 1;
	}
	else
	{
		printf("Connected\n");
	}

	//
	//	Data to send to create a HTTP request.
	//
	char* write_buf = "POST / HTTP/1.1\r\n"
					  "Host: " HOST "\r\n"
					  "Authorization: Basic " APIKEY "\r\n"
					  "Connection: close\r\n"
					  "\r\n";

	//
	//	 Attempts to write len bytes from buf to BIO
	//
	if(BIO_write(bio, write_buf, strlen(write_buf)) <= 0)
	{
		//
		//	Handle failed write here
		//
		if(!BIO_should_retry(bio))
		{
			// Not worth implementing, but worth knowing.
		}

		//
		//	-> Let us know about the failed write
		//
		printf("Failed write\n");
	}

	//
	//	Variables used to read the response from the server
	//
	int size;
	char buf[1024];

	//
	//	Read the response message
	//
	for(;;)
	{
		//
		//	Put response in a buffer of size.
		//
		size = BIO_read(bio, buf, 1023);

		//
		//	If no more data, then exit the loop
		//
		if(size <= 0)
		{
		 	break;
		}

		buf[size] = 0;

		printf("%s", buf);
	}

	//
	//	Clean after ourselves
	//
	BIO_free_all(bio);
	SSL_CTX_free(ctx);

	return 0;
}