# Linux Client CLI for WiMi

This client is the main component which you run on your RaspberryPi, so it can make HTTP requests to the server to let it aquier your public IP.

To work, this app needs the following changes in the code:

- URL to your server
- the API Key

Bot this values can be found in the welcome page of your server after the first installation. Click the `view` button at the end of the installation page, to see this values.

After you replace the values in this code, you have to install the development version of OpenSSL on your RaspberryPi. To do so, type the following command in your command line:

`sudo apt-get install libssl-dev`

Once this is done, in the Clinet-CLI directory type `make`, and the app will compile and run for the first time. If everything goes well, you should get a `OK` response from the server.

**Pro-Tip**: be patient when waiting for the replay since, Heroku might have turned of the server on the free tier option. Thus taking a moment to start it.

# Cron setup

Now that you have the binary app compiled under the name of `wimi.o`, you can setup your crone to run this app on a regular basis to make sure your IP is kept up to date on the server. To do so, follow this instructions:

1. Get the path to your compiled file by typing `pwd` in the client-cli directory. In my case the file is located under this path `/home/pi/Documents/GitHub/What-Is-My-IP/client-cl`.
1. Copy the path
1. Run `crontab -e` to open the cron file with the default text editor in your system, and paste this line `*/15 * * * * /home/pi/Documents/GitHub/What-Is-My-IP/client-cli/wimi.o >/dev/null 2>&1` (of course change your path if different)
1. Save your changes

This Cron line will run the WiMi app every 15 minutes, and will redirect the result to the `/dev/null` void. If you would like to change the frequency of the Cron job, you can use a on-line generator for make your life easier if you are not fluent with the Cron format. I recommend this site: http://crontab-generator.org.

In addition, to check that evrything works as expected, you should monitor the system logs to see if the Cron job is been executed when it should, by using this command `tail -f /var/log/syslog` in your termianl window.
