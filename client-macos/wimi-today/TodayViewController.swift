//
//  TodayViewController.swift
//  wimi-today
//
//  Created by David Gatti on 7/3/16.
//  Copyright © 2016 David Gatti. All rights reserved.
//

import Cocoa
import NotificationCenter

class TodayViewController: NSViewController, NCWidgetProviding {

	//
	//	The height constraint used to show or hide the settign section
	//
    @IBOutlet weak var viewHeight: NSLayoutConstraint!

	//
	// Lable used to display the IP
	//
	@IBOutlet weak var tfIP: NSTextField!

	//
	//	Lable used to display the time the server was pinged by the linux client
	//
    @IBOutlet weak var tfTime: NSTextField!

	//
	//	Loading the data from the setting section
	//
    let defaults = NSUserDefaults.standardUserDefaults()

    override var nibName: String? {
        return "TodayViewController"
    }

    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
        // Update your data and prepare for a snapshot. Call completion handler when you are done
        // with NoData if nothing has changed or NewData if there is new data since the last
        // time we called you
        completionHandler(.NoData)
		print("ping")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

//        if let appDomain = NSBundle.mainBundle().bundleIdentifier
//        {
//            defaults.removePersistentDomainForName(appDomain);
//        }

		//
		//	Load the data from the server
		//
        getData();

		//
		//	Listen to any chagnes in the user defaults
		//
        defaults.addObserver(self, forKeyPath: "apikey", options: NSKeyValueObservingOptions.New, context: nil)
        defaults.addObserver(self, forKeyPath: "url", options: NSKeyValueObservingOptions.New, context: nil)

    }

	//
	//	React to chagnes in user defautls
	//
    override func observeValueForKeyPath(keyPath: String?,
								 ofObject object: AnyObject?,
								          change: [String : AnyObject]?,
										 context: UnsafeMutablePointer<Void>)
	{
		//
		//	Try to load the data
		//
        getData();
    }

	//
	//	() that connects to the server
	//
    func getData()
    {
        //
        //  Loading the API_KEY from the user defaults
        //
        if let apikeyD = defaults.objectForKey("apikey"), urlD = defaults.objectForKey("url")
        {
            //
            //  Converting the Strign to UTF8
            //
            let utf8str = apikeyD.dataUsingEncoding(NSUTF8StringEncoding);

            //
            // Gettign ready to accept the content of the conversion
            //
            var API_KEY = "";

            //
            //  Convert the raw API_KEY in to Base64
            //
            if let base64 = utf8str?.base64EncodedDataWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
            {
                API_KEY = "Basic " + String(data: base64, encoding: NSUTF8StringEncoding)!
            }

            //
            //  Creatign URL from User Defaults
            //
            let url = NSURL(string: urlD as! String)

            //
            //  1. Create the request
            //
            let request = NSMutableURLRequest(URL: url!)

            //
            //  2. Set the Authorization header
            //
            request.setValue(API_KEY, forHTTPHeaderField: "Authorization");

            //
            //  3. Create the Connection session
            //
            let session = NSURLSession.sharedSession()

            //
            //  4. Handle the HTTP Response
            //
            let task = session.dataTaskWithRequest(request){(data, response, error) in

                if let httpResponse = response as? NSHTTPURLResponse
                {
                    if(httpResponse.statusCode <= 200)
                    {
                        //
                        //  1. Convert the buffer in to a string
                        //
                        let strResponse = NSString(data: data!, encoding: NSUTF8StringEncoding)

                        //
                        //  Check if the string is empty or not
                        //
                        if(strResponse?.length > 0)
                        {
                            //
                            //  2. Split the string by the new line char
                            //
                            let arrResponse = strResponse?.componentsSeparatedByString("\n")

                            //
                            //  3. Convert the Unix timestamp string in to a Doubble
                            //
                            let unixtime = Double(arrResponse![1]);

                            //
                            //  4. Create a date based on the Unix timestamp
                            //
                            let date = NSDate(timeIntervalSince1970: unixtime!)

                            //
                            //  5. Format the date in to a human readable format
                            //     while usign the user locale.
                            //
                            let formatter = NSDateFormatter()
                            formatter.dateStyle = NSDateFormatterStyle.LongStyle
                            formatter.timeStyle = .MediumStyle

                            //
                            //  6. Create the final date time string
                            //
                            let dateString = formatter.stringFromDate(date)

                            //
                            //  -> Print out
                            //
                            print("IP: ", arrResponse![0])
                            print("Time: ", dateString)

                            //
                            //  -> UI display
                            //
                            dispatch_async(dispatch_get_main_queue(), {

                                self.tfIP.stringValue = arrResponse![0];
                                self.tfTime.stringValue = dateString;

								//
								//	This will amke sure taht the settgins will be hiiden
								//	once the settigns are set.
								//
								self.viewHeight.constant = 90;

                            })
                        }
                        
                    }
                    else
                    {
						//
						//	If no user defaults, show the settigns section
						//
                        self.viewHeight.constant = 188;
                    }
                }
            }
            
            //
            // 5. Make the HTTP request.
            //
            task.resume()
        }
        else
        {
			//
			//	If unable to connect to the server show the settign section
			//
            self.viewHeight.constant = 188;
        }
    }

}
