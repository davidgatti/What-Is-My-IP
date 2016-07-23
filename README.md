# WiMi, What Is My IP

WiMi is a simple solution to constantly stay up to date with your ever changing public IP. We all like to have our own small server using small computers like a Raspberry Pi, but the problem is that our ISPs don’t allow us to have a fixed IP, or if they do - such option is just to expensive for our hobby projects.

A solution to this problem is to use a service which manages a domain name for us, and change the IP at which it points. This solution are typically payed or when they are free they come with some annoying limitations put in place to force you to upgrade to a premium account.

This is why I created WiMi and built a small solution to solve this issue in a way that it is open to everybody, and most importantly - anyone can host their own server on Heroku with their free option.

With this solution you are in total control. To the point that you don’t have to use Heroku. I choose them as the default server provider since they realized a nice mechanism to quickly crate a server and have the software running in seconds.

## Components

This project consist for now of 3 parts:

1. The server written in NodeJS
1. The CLI client for Linux written in C
1. The MacOS client written in Swift

## The server

After clicking on the button bellow, you’ll be redirected to Heroku where a simple page will instruct you how to install the app. This approach is simple  to the point where even the environment variables are going to be created automatically for you. Start by click the button bellow.

<div align="center"><a href="https://heroku.com/deploy?template=https://github.com/davidgatti/What-Is-My-IP" target="_blank"><img src="https://www.herokucdn.com/deploy/button.sv"></a></div>

An important part of this step is the final process where at the end you get two buttons. The important one is named “view”. You have to click on it to launch the welcome page and get access to your auto generated API KEY and the URL of the app.

<div align="center"><img src="https://github.com/davidgatti/What-Is-My-IP/blob/master/buttons.png"></div>

This two peaces of information are crucial for the following steps.

The Linux Client

This peace of software is the one command that will make an empty HTTP request to the newly created server, so the server can aquifer our public IP. This app will have to be run every so often, ideal using a Cron job.

Visit the [client-cli](https://github.com/davidgatti/What-Is-My-IP/tree/master/client-cli) directory to read more about how to setup everything.

## The MacOS Client

This app consist of a Today Widget which will be easy accessible no mater where you are in the system. A gentile swipe with two finger from right to left on the track pad will revel your IP.

The source code is available in the client-macos folder, but in this case you don’t have to compile the app yourself. Visit the “releases” section of this repository to find the compile version of this app.

Visit the [client-macos](https://github.com/davidgatti/What-Is-My-IP/tree/master/client-macos) directory to read more about how to install the app.

## To sum it all up

I hope you’ll enjoy this project, and you’ll find it useful. If you have any questions, or would like to fill a bug, please use the Issue section of this repository to do so.

## Help Needed

Right now the project only has a MacOS client. If you know how to write a Windows or Linux app, feel free to submit a Pull Request with your work. One important thing thought, your code need to be spotless, with comments all over the place, and written with the intent to teach others.

## My other Projects

If you like this project, please check my other ones.
