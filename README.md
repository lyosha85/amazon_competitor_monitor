# README

Deployed here: https://amazon-competitor-monitor.herokuapp.com/groups/8/changes/20170828

Note: I added a couple of hot sellers to my list and I ended up encountering a whole variety of different responses, such as when an item was sold out, removed or became a child-asin. If I had more time, I would write better error handling after learning more about the different kind of responses I can get.


## TODO - Required

* Create notification model with notified:boolean to prevent duplicate notifications
* Run amazon query jobs in group batches to make easy to schedule a notification per group
* Move sibling record max validation into concern
* Rename vacuum service
* Make the site more visually appealing

## TODO - Nice to have
* React & material front-end
* Save product images from amazon to show what picture was deleted
* Separate the snapshot collection and serving app into separate app.
* Error handling for asins that have been removed
* Registration & authentication
* Show a list of snapshots
* Better error handling
* Smarter way of retrying jobs and information collection
* Create a batch of groups to send out notifications
* Add groups controller specs
* Add asin,amazon_link specs
