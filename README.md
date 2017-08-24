# README

## TODO - Required
* Add and configure rspec, factorygirl
* Create account model
* Create group model
* Validate max 10 groups per user
* Validate max 8 products per group
* Create snapshot model
* Snapshot creation job
* Snapshot job - product attributes
* Snapshot job - inventory count
* Comparison page
* Create notification model
* Create email template showing changes
* Daily email notification job (end of day?)
* Add form to add a new group
* Add form to add new asin / amazon url
* Extract asin from url
* Create a heroku cron job
*
*


## TODO - Nice to have
* React & material front-end
* Save product images from amazon to show what picture was deleted
*
*

## Requirements

I sell on Amazon and want to monitor my competitors
As a user, I want to know if the price, rank, inventory, reviews, title/images/features of my competitors change
So that I can keep track of my market.

### Build a system that:
1. Monitors competitors public listing product page
2. Checks
a. Price
b. Title
c. Images
d. Features
e. Number of Reviews
f. Best Seller Rank
g. Inventory
3. Stores the data and notifies if there is a change based on a daily check
4. Single notification of all changes
5. The system allows me to add up to 8 competitors in a single group using the
amazon link or Product ASIN (amazon ID: e.g. B01MCZ1JGZ)
6. I can have up to 10 groups of products I am monitoring. (i.e. I can monitor 10 sets
of 8 competitors).

### Sample Products:

I sell Baseball Bats

This is my product:
https://www.amazon.com/EASTON-BB16S400-BBCOR-ADULT-BASEBALL/dp/B00ZLJ1QGC
/ref=sr_1_5?ie=UTF8&qid=1501170697&sr=8-5&keywords=baseball+bats

I want to monitor these competitors:
1. https://www.amazon.com/Louisville-Slugger-Genuine-Baseball-Natural/dp/B01K8
B5BYU/ref=sr_1_3?ie=UTF8&qid=1501170697&sr=8-3&keywords=baseball+bats
2. https://www.amazon.com/Louisville-Slugger-Omaha-BBCOR-Baseball/dp/B01JP6
E9HY/ref=sr_1_6?ie=UTF8&qid=1501170697&sr=8-6&keywords=baseball+bats
3. https://www.amazon.com/Rawlings-YBRR11-Raptor-Youth-Barrel/dp/B011BX2C50
/ref=sr_1_7?ie=UTF8&qid=1501170697&sr=8-7&keywords=baseball+bats
4. https://www.amazon.com/BB-W-Wooden-baseball-bat-size/dp/B002BZIVSU/ref=s
r_1_8?ie=UTF8&qid=1501170697&sr=8-8&keywords=baseball+bats
5. https://www.amazon.com/Marucci-Cat-BBCOR-Baseball-inch/dp/B00L9A95T2/re
f=sr_1_9?ie=UTF8&qid=1501170697&sr=8-9&keywords=baseball+bats

Best Seller Rank
In this case #9926 in sports and outdoors (the main category)

Inventory Check
Add to cart
Edit the cart to add 999 per product
Amazon reports the actual stock if under 999. If over 999 use 999 as inventory.

## What are we looking for?
1. Firstly that you have fun with the exercise. This does not have to be a full blown
solution.
2. We are looking at how you would model this. Specially around all the “-ilities”
3. Your thought process. This should be reflected in your commit history.
4. Any documentation and diagramming that is needed for the solution.
5. How you would make sure that we are building what the customer wants.

## Deliverables
1. A Ruby on Rails solution.
2. You can use any frontend framework you like.
3. A README explaining how to set it up and run it.
4. A project on github, bitbucket or a zip file containing git repository
