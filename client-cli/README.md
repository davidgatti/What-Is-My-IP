# Linux Client CLI for WiMi

This client is the main component that you run on your RaspberryPi, so it can make HTTP requests to the server.

To work, this app needs the following changes in the code:

- URL to your server
- the API Key

These values can be found in the welcome page of your server after the first installation. Click the view button at the end of the installation page to see them.

After you replace the values in this code, you have to install the development version of OpenSSL on your RaspberryPi. To do so, type the following command in your command line:

`sudo apt-get install libssl-dev`

Once this is done, type `make` in the Client-CLI directory, and the app will compile and run for the first time. If everything goes well, you should get an `OK`response from the server.

**Pro-Tip**: Be patient when waiting for the response, since Heroku might have turned off the server, thus taking a moment to start it back up.

# Cron setup

Now that you have the binary app compiled under the name of `wimi.o`, you can set up your Cron job to run this app on a regular basis and ensure that your IP is kept up to date on the server. To do so, follow these instructions:


1. Get the path to your compiled file by typing `pwd` in the `client-cli` directory. In my case, the file is located under this path `/home/pi/Documents/GitHub/What-Is-My-IP/client-cl`.
1. Copy the path
1. Run `crontab -e` to open the cron file with the default text editor in your system, and paste this line `*/15 * * * * /home/pi/Documents/GitHub/What-Is-My-IP/client-cli/wimi.o >/dev/null 2>&1` (of course change your path if different)
1. Save your changes.

This Cron line will run the WiMi app every 15 minutes, and will redirect the result to the `/dev/null` void. If you are not fluent with the Cron format, and you would like to change the frequency of the Cron job, you can use an on-line generator to make your life easier. I recommend this site: http://crontab-generator.org.

In addition, you should use this command in your terminal window to monitor the system logs to be sure that everything works as expected and that the Cron job is being executed when it should: `tail -f /var/log/syslog`.
