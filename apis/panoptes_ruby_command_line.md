How to query Panoptes via Ruby console
======================================

Sometimes you will want to get live information from the Panoptes backend that is not available from the APIs. For staff and those with the appropriate level of access, the following approach is possible:

First, find the IP of a Panoptes dump worker instance. You can do this by typing ``lita aws ip panoptes dump production`` on Slack. Pick an instance, such as ``ec2-54-174-166-171.compute-1.amazonaws.com``.

Now SSH into that instance (you'll need to be on an authorised network or VPN and you'll need to have the key for access)::

    ssh -i /code/Production/keys/zooniverse_1.pem ubuntu@ec2-54-174-166-171.compute-1.amazonaws.com

Now step inside the docker container (you can validate the container name using ``docker ps``)::

    docker exec -it panoptesdumpworker_panoptes_1 bash

Now start a ruby console::

    bundle exec rails c

Now you can run commands using the domain model objects defined in the Ruby code.

**IMPORTANT:** This gives you superuser access, with no constraints. This should only be done for reading and querying, not for modifying data. Great care should be taken when running heavy queries and data manipulation using this "API-bypassing" approach is strongly discouraged.

Here is an example of using this Ruby console to find an accurate count of retired subjects so far for a specific project, given the project ID (in this case ``988``) and workflow ID (in this case ``512``)::

```ruby
p = Project.find(988)
w = Workflow.find(512)
sws = SubjectWorkflowStatus.retired.where(workflow_id: w.id)
sws = sws.where("subject_workflow_counts.created_at >= ?", p.launch_date)
sws.count
```