Missing Label - Backend
===========

App:
[Heroku App](https://missinglabel.herokuapp.com/)

Under the Hood
===========


![schema](app/assets/images/missing_label_schema.png)


Rails API
===========

Our current Rails API obtains nutrition data from the USDA. The farm locations are represented as a response from the Google maps API.

The system is built to support retrieving additional food data from GS1's API (public availability is expected in 2015).  We have contacted representatives from GS1 to ensure our system conforms to their expected format. This will make it easier to enhance the app to support their live data feed.


[Frontend repo](https://github.com/MissingLabel/missingapp)
