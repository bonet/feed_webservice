<pre>
  ______            _  __          __  _                         _          
 |  ____|          | | \ \        / / | |                       (_)         
 | |__ ___  ___  __| |  \ \  /\  / /__| |__  ___  ___ _ ____   ___  ___ ___ 
 |  __/ _ \/ _ \/ _` |   \ \/  \/ / _ \ '_ \/ __|/ _ \ '__\ \ / / |/ __/ _ \
 | | |  __/  __/ (_| |    \  /\  /  __/ |_) \__ \  __/ |   \ V /| | (_|  __/
 |_|  \___|\___|\__,_|     \/  \/ \___|_.__/|___/\___|_|    \_/ |_|\___\___|
                                                                            
</pre>


Overview
========

Feed Webservice is a webservice that supplies updated newsfeed information in JSON format and is designed 
to be run periodically.  Each newsfeed datum contains 2 properties: Category and Publisher; the returning results
can be filtered based on each of the properties.


Getting Started
===============

Clone this repository and bundle:

git clone git@github.com:bonet/feed_webservice.git
bundle install
