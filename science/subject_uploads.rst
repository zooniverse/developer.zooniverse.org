How to upload externally-hosted images to Project Builder Subject Sets
======================================================================

Panoptes supports the concept of an "external" subject, that is one whose source images are hosted externally rather
than being uploaded through the project builder to S3 in the normal manner.

Currently this functionality is not available through the project builder, nor is it available via the API.

Instead you will have do one of the following:

A. Use the "run rake task" job on Jenkins to add your images
B. Gain access to a Panoptes dump worker instance and run the rake task to add your images there
C. Alternatively you could look at using the `subject uploader script <https://github.com/zooniverse/panoptes-subject-uploader>`_ (this is not covered in this document).

This document explains approaches A and B, as well as the preliminary steps common to all approaches.

Step 1 - Create your CSV
------------------------

This is common to both approaches. You'll need to create a CSV, with a header row, where the first column is called
``url`` and contains the URL of your image. One image per row. (TODO: Can someone add info on how to upload a
multiple-image subject?). The remaining fields are metadata, these will be available in the subject viewer interface
via the (i) button - so you may want to convert them to "human-friendly" strings rather than database values.
Here is an example of a trio of scripts (`one <https://github.com/zooniverse/mongo-subject-extractor/blob/master/generate_detailed_consensus.rb>`_, `two <https://github.com/zooniverse/serengeti-analysis-scripts/blob/master/generate-species-csvs.py>`_ , `three <https://github.com/zooniverse/serengeti-analysis-scripts/blob/master/pick-random-csv-subsets.py>`_) which, when run in sequence, will create CSVs from Snapshot Serengeti subjects.

Once you have a CSV you should upload it to a publicly available URL.
One of the easiest ways to do this is to use `gist <https://gist.github.com/>`_ (`command-line uploader here <https://github.com/defunkt/gist>`_) from github.

**Important note**: Once you have got the gist link, such as ``https://gist.github.com/alexbfree/a913899eb9cef84110da#file-zebra-100-csv``, you need to actually paste it into your address bar, then click raw on the csv file within the github UI to get the expanded URL, something like this ``https://gist.githubusercontent.com/alexbfree/a913899eb9cef84110da/raw/dd5e3e859ebfd9c8be066b781cbb148a4976ff9e/zebra-100.csv`` (note the change of domain). Your upload will fail if you don't do this.

Step 2 - Prepare subject set and find the necessary IDs
-------------------------------------------------------

This is also common to both approaches.

You will need to find three IDs - your project ID, your user ID, and the ID of the (probably empty) subject set you've created in your Project Builder Workflow to house the new images.

You can find the project ID by looking at the URL when you are viewing the project in the project builder.
For example, ``https://www.zooniverse.org/lab/988`` tells me my project ID is ``988``.

You can find your user ID by using the developer console in your browser to monitor the network traffic when you reload the Zooniverse home page. Look for the request to ``/api/me`` and it should start with something like ``{"users":[{"id":"209","login":"alexbfree"`` - this tells me my user ID is `209``.

The user ID you use for the upload will own the images and they will count against the upload limit for that user.

Finally you need to create a new (empty) subject set in the Project Builder (or, you can upload to an existing one if you wish). Once the subject set is created (you'll need to defocus the subject set name box by clicking elsewhere on the page to save it), you can now examine the URL to find the subject set ID. For example ``https://www.zooniverse.org/lab/988/subject-set/3941`` tells me the subject set ID is ``3491``.

Now that you have the project ID, user ID, subject set ID and raw CSV URL, you can proceed to create the rake task, using either of the two approaches:

Step 3A - Create the rake task from the commandline
---------------------------------------------------

This approach takes longer, but is faster and useful if you have more than one file to upload.

First, find the IP of a Panoptes dump worker instance. You can do this by typing `lita aws ip panoptes dump` on Slack. Pick an instance, such as ``ec2-54-174-166-171.compute-1.amazonaws.com``.

Now SSH into that instance (you'll need to be on an authorised network or VPN):
``ssh -i /code/Production/keys/zooniverse_1.pem ubuntu@ec2-54-174-166-171.compute-1.amazonaws.com``

Now step inside the docker container (you can validate the container name using ``docker ps``):
``docker exec -it panoptesdumpworker_panoptes_1 bash``

Now you can run your rake command as follows, where ``projectID``, ``userID``, ``setID``, ``url`` are replaced by the values you determined above. Don't include the angle brackets.
``bundle exec rake subjects:import[projectID,userID,setID,url]``

You can track the progress of your import job in `Sidekiq <https://panoptes.zooniverse.org/sidekiq/>`_.


Step 3B - Create the rake task from Jenkins
-------------------------------------------

This approach is easier, but slower, as it has to spin up a VM. It's inefficient if you have many CSVs to upload.

Log into `Jenkins <http://jenkins.zooniverse.org>`_, and go the `Run rake task <https://jenkins.zooniverse.org/job/Run%20rake%20task>`_ job.

Click on ``Build with parameters`` on the left hand menu.

construct a string like this:
``subjects:import[projectID,userID,setID,url]``
and paste it into the ``RAKE_TASK_NAME`` box.

Make sure to select ``panoptes-api`` from the ``INSTANCE_NAME`` box.
Click Build.

You can monitor your import task like any other Jenkins job, from the dashboard.




