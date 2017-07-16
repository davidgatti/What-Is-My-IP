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

If you've enjoyed this article/project, please consider giving it a 🌟 or donate.

- [![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://www.paypal.me/gattidavid/25)
- [![Star on GitHub](https://img.shields.io/github/stars/davidgatti/What-Is-My-IP.svg?style=social)](https://github.com/davidgatti/How-to-Stream-Movies-using-NodeJS/stargazers)
- [![Watch on GitHub](https://img.shields.io/github/watchers/davidgatti/What-Is-My-IP.svg?style=social)](https://github.com/davidgatti/How-to-Stream-Movies-using-NodeJS/watchers)

Also check out my [GitHub account](https://github.com/davidgatti), where I have other articles and apps that you might find interesting.

## Where to follow

You can follow me on social media 🐙😇, at the following locations:

- [GitHub](https://github.com/davidgatti)
- [Twitter](https://twitter.com/dawidgatti)
- [Instagram](https://www.instagram.com/gattidavid/)

## More about me

I don’t only live on GitHub, I try to do many things not to get bored 🙃. To learn more about me, you can visit the following links:

- [Podcasts](http://david.gatti.pl/podcasts)
- [Articles](http://david.gatti.pl/articles)
- [Technical Articles](http://david.gatti.pl/technical_articles)
- [Software Projects](http://david.gatti.pl/software_projects)
- [Hardware Projects](http://david.gatti.pl/hardware_projects)

