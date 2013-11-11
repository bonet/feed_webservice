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

Feed Webservice is a web service that provides newsfeed information in JSON format and is designed to be updated periodically. 
The newsfeed content is grouped either by Category and Publisher.  


Development Environment Setup
=============================

1. `git clone git@github.com:bonet/feed_webservice.git`
2. `bundle install`
3. `cp application.yml.sample application.yml`, and then fill `application.yml` credentials
4. run MongoDB server in the background
5. run Guard: `guard`


Data Setup
==========

1. Create new Categories in `http://[yourdomain.com]/admin/categories/new`

2. Create new Publishers in `http://[yourdomain.com]/admin/publishers/new`

3. After creating at least 1 Category and 1 Publisher, create a Newsfeed item (which is a combination of a Category and a Publisher)
   in `http://[yourdomain.com]/admin/newsfeeds/new` by adding a comma separated value of related feed URLs

4. Run / wait for the cron task to update the feed URL contents and related database info


Data Retrieval / API Usage
==========================

Feed Webservice provides several APIs to retrieve Newsfeed data in various format.

* To retrieve a list of available Categories and Publishers, e.g. for building website menu

  - Default Data
  
    `curl http://[yourdomain.com]/categories_per_publisher`
  
  - Personalized Data
  
    `curl http://[yourdomain.com]/personalized_categories_per_publisher/[:id]`
    
    
* To retrieve a list of Newsfeed content URLs

  - Default Data
  
    `curl http://[yourdomain.com]/default_newsfeed_aggregate`
    
  - Personalized Data
  
    `curl http://[yourdomain.com]/newsfeed_aggregates/[:id]`
