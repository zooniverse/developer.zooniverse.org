The Platform
============

The latest Zooniverse platform consists of a number of services working together.

.. raw:: html

    <script src="https://www.gliffy.com/diagramEmbed.js" type="text/javascript"></script>
    <script type="text/javascript">gliffy_did="10471345";embedGliffy();</script>

* **Panoptes** is the main API endpoint in our platform. This is where user logins
  happen, and what stores data about projects, workflows, subjects, and
  classifications. https://zooniverse.github.io/Panoptes

* **Cellect** is a service that selects a few randomly-chosen subjects for a
  user to work on next. 

* **Designator** is an alternative to Cellect. It's written in Elixir with no 
  C-based dependencies. It differentiates by loading and unloading data automatically,
  and offering options to bias selection to certain sets, either per workflow or even on a per-user basis.

* **Caesar** is an auxilliary service that deals with subject retirement rules.
  Panoptes itself comes with a very simple threshold on the number of
  classifications per subject. Caesar is where we implement any project-specific
  retirement rules (although obviously we try and generalise when possible).
  https://zooniverse.github.io/caesar

* **ZooEventStats** gathers metrics on everything in our platform.

* **Aggregation**

Services still under development
--------------------------------

The following services are still being built and are not yet in active use:

* **Warehouse** will take over the exporting of classifications for a project.

* **Notifications** will maintain an open websocket (or long-polling)
  connection to browsers, so that we get a channel to push notifications to
  browsers directly.
