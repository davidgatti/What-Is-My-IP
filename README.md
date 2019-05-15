# WiMi: What Is My IP?

<img src="https://github.com/davidgatti/What-Is-My-IP/blob/master/header.png" align="right">

WiMi is a simple solution that allows you to constantly stay up to date with your ever-changing public IP. We all would like to have our own small server using a Raspberry Pi, but the problem is that our ISPs don’t allow us to have a fixed IP; or if they do, such an option is just too expensive for our hobby projects.

A solution to this problem is to use a service that manages a domain name for us, and change the IP at which it points. This type of solution is typically paid. When it is free, it comes with some annoying limitations that are put in place to force you to upgrade to a premium account.

This is why I created WiMi as a small solution for this issue that it is open to everybody. Most importantly, anyone can host their own server on Heroku, using their free tier.

With this solution, you are in total control, to the point that you don’t have to use Heroku. I choose them as the default server provider since they have a nice mechanism to quickly create a server and have an app up and running in seconds.

## Components

This project consists of three parts:

1. The server, written in NodeJS
1. The CLI client for Linux, written in C
1. The MacOS client, written in Swift

## The Server

This is a NodeJS server that will run on Heroku. The purpose of this application is to listen for an HTTP POST request from the Linux Client, and extract the public IP from the request. The macOS client, on the other hand, will be able to make a GET request to the server to get and display your public IP.

Follow the instructions in the Server folder to learn how to install the server on Heroku.

## The Linux Client

This piece of software will send an empty HTTP request to the newly created server, so the server can acquire our public IP. This app will have to be run every so often, ideally using a Cron job.

Visit the [client-cli](https://github.com/davidgatti/What-Is-My-IP/tree/master/client-cli) directory to read more about how to set everything up.

## The MacOS Client

This app consists of a Today Widget, which will be easily accessible, no matter where you are in the system. A gentle swipe with two fingers from right to left on the track pad will reveal your IP.

The source code is available in the client-macos folder, but in this case you don’t have to compile the app yourself. Visit the “releases” section of this repository to find the compiled version of this app.

Visit the [client-macos](https://github.com/davidgatti/What-Is-My-IP/tree/master/client-macos) directory to read more about how to use the app.

## To sum it all up

I hope you’ll enjoy this project, and find it useful. If you have any questions, or would like to fix a bug, please use the Issue section of this repository to do so.

## Help Needed

Right now, the project only has a MacOS client. If you know how to write a Windows or Linux app, feel free to submit a Pull Request with your work. One important thing, though - your code needs to be spotless (clean looking), with comments all over the place, and written with the intent to teach others.

# The End

If you enjoyed this project, please consider giving it a 🌟. And check out my [GitHub account](https://github.com/davidgatti), where you'll find additional resources you might find useful or interesting.

## Sponsor 🎊

This project is brought to you by 0x4447 LLC, a software company specializing in building custom solutions on top of AWS. Follow this link to learn more: https://0x4447.com. Alternatively, send an email to [hello@0x4447.email](mailto:hello@0x4447.email?Subject=Hello%20From%20Repo&Body=Hi%2C%0A%0AMy%20name%20is%20NAME%2C%20and%20I%27d%20like%20to%20get%20in%20touch%20with%20someone%20at%200x4447.%0A%0AI%27d%20like%20to%20discuss%20the%20following%20topics%3A%0A%0A-%20LIST_OF_TOPICS_TO_DISCUSS%0A%0ASome%20useful%20information%3A%0A%0A-%20My%20full%20name%20is%3A%20FIRST_NAME%20LAST_NAME%0A-%20My%20time%20zone%20is%3A%20TIME_ZONE%0A-%20My%20working%20hours%20are%20from%3A%20TIME%20till%20TIME%0A-%20My%20company%20name%20is%3A%20COMPANY%20NAME%0A-%20My%20company%20website%20is%3A%20https%3A%2F%2F%0A%0ABest%20regards.).
