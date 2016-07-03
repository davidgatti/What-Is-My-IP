//
//  main.c
//  wimi
//
//  Created by David Gatti on 7/2/16.
//  Copyright © 2016 David Gatti. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#include <netdb.h>
#include <netinet/in.h>

#include <string.h>
#include <time.h>
#include <signal.h>

int main(int argc, char **argv)
{
    //
    //  Check for arguments
    //
    if( argc == 2 ) {
        printf("The argument supplied is %s\n", argv[1]);
    }
    else if( argc > 2 ) {
        printf("Too many arguments supplied.\n");
    }
    else {
        printf("One argument expected.\n");
    }

    char host[] = "secure-earth-47559.herokuapp.com";
    int sockfd;
    int portno;
    struct sockaddr_in serv_addr;
    struct hostent *server;
    
    //
    //  Create a socket point
    //
    sockfd = socket(AF_INET, SOCK_STREAM, 0);

    //
    //  -> Show error if any
    //
    if (sockfd < 0)
    {
        perror("ERROR opening socket");
        exit(1);
    }

    //
    //  converts the string argument to an integer (type int).
    //
    portno = atoi("5000");

    //
    //  Provided by netdb.h
    //
    server = gethostbyname(host);

    //
    //  -> Show error if any
    //
    if (server == NULL)
    {
        fprintf(stderr,"ERROR, no such host\n");
        exit(0);
    }

    //
    //  Fill with 0
    //
    bzero((char *) &serv_addr, sizeof(serv_addr));

    //
    //  set the type of connection to TCP/IP
    //
    serv_addr.sin_family = AF_INET;

    //
    //  pointer to the first IP address
    //
    bcopy((char *)server->h_addr, (char *)&serv_addr.sin_addr.s_addr, server->h_length);

    //
    //  converts the unsigned short integer hostshort from host byte
    //  order to network byte order.
    //
    serv_addr.sin_port = htons(portno);

    //
    //  Now connect to the server
    //
    if (connect(sockfd, (struct sockaddr*)&serv_addr, sizeof(serv_addr)) < 0)
    {
        perror("ERROR connecting");
        exit(1);
    }

    //
    //  Now ask for a message from the user, this message
    //  will be read by server
    //
    char ble[54] = "POST / HTTP/1.1\nAuthorization: Basic cXdld3FlOg==\n\n";

    while(1)
    {
        //
        //  Send message to the server
        //
        long w = write(sockfd, ble, strlen(ble));
        
        if (w < 0)
        {
            perror("ERROR writing to socket");
            exit(1);
        }
        
        //
        //  Now read server response
        //
        char buffer[256];
        bzero(buffer, 256);

        long r = read(sockfd, buffer, 255);
        
        if (r < 0)
        {
            perror("ERROR reading from socket");
            exit(1);
        }
        
        printf("%s\n\n", buffer);

        sleep(1);
    }
    
    return 0;
}