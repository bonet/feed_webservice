#Feed Webservice

![Codeship Status](https://www.codeship.io/projects/bf2febe0-3493-0131-92d2-228038a705a1/status)

[![Coverage Status](https://coveralls.io/repos/bonet/feed_webservice/badge.png?branch=master)](https://coveralls.io/r/bonet/feed_webservice?branch=master)

## Overview

Feed Webservice is a web service that provides newsfeed information in JSON format and is designed to be updated periodically. 
The newsfeed content is grouped either by Category and Publisher.  


## Development Environment Setup

1. `git clone git@github.com:bonet/feed_webservice.git`
2. `bundle install`
3. `cp application.yml.sample application.yml`, and then fill `application.yml` credentials
4. run MongoDB server in the background
5. run Guard: `guard`


## Data Setup

1. Create new Categories in `http://[yourdomain.com]/admin/categories/new`

2. Create new Publishers in `http://[yourdomain.com]/admin/publishers/new`

3. After creating at least 1 Category and 1 Publisher, create a Newsfeed item (which is a combination of a Category and a Publisher)
   in `http://[yourdomain.com]/admin/newsfeeds/new` by adding a comma separated value of related feed URLs

4. Run / wait for the cron tasks (in `lib/tasks/scheduler.rake`) to update NewsfeedAggregates and CategoriesPerPublisher data


## API Usage

Feed Webservice provides several APIs to retrieve Newsfeed data in various format.

* Important: Before calling the `categories_per_publishers` or `newsfeed_aggregates` API, first we need to create a new NewsfeedAggregate by supplying the desired Newsfeed IDs in CSV format, e.g.:

  `curl --data "newsfeed_ids=1,2,4" http://[yourdomain.com]/newsfeed_aggregates`
  

* To retrieve a list of available Categories and Publishers, e.g. for building website menu, we can use the following APIs:

  - Default Data (API name: `default_categories_per_publisher`)
  
    `curl http://[yourdomain.com]/default_categories_per_publisher`
  
  - Personalized Data (API name: `categories_per_publishers`)
  
    `curl http://[yourdomain.com]/categories_per_publishers/[:newsfeed_aggregate_id]`
    
    
* To retrieve a list of Newsfeed content URLs, we can use the following APIs:

  - Default Data (API name: `default_newsfeed_aggregate`)
  
    `curl http://[yourdomain.com]/default_newsfeed_aggregate`
    
  - Personalized Data (API name: `newsfeed_aggregates`)
  
    `curl http://[yourdomain.com]/newsfeed_aggregates/[:id]`
