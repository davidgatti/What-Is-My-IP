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

    override var nibName: String? {
        return "TodayViewController"
    }

    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
        // Update your data and prepare for a snapshot. Call completion handler when you are done
        // with NoData if nothing has changed or NewData if there is new data since the last
        // time we called you
        completionHandler(.NoData)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        //
        //  Temporary Key to be removed
        //
        let API_KEY = "Basic MzQzMzdlMmItYzgzOC00MWE5LThhMzQtZWU0Y2JhNTRmOGU1Og==";

        //
        //  Temporary URL
        //
        let url = NSURL(string: "https://stark-scrubland-44326.herokuapp.com")

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
        //  4. Combine evrything toghether
        //
        let task = session.dataTaskWithRequest(request){(data, response, error) in

            //
            //  1. Convert the buffer in to a string
            //
            let strResponse = NSString(data: data!, encoding: NSUTF8StringEncoding)

            //
            //  2. Split the string by the new line char
            //
            let box = strResponse?.componentsSeparatedByString("\n")

            //
            //  -> Print out
            //
            print("IP: ", box![0])
            print("Time: ", box![1])
        }

        //
        // 5. Make the HTTP request.
        //
        task.resume()

    }

}
