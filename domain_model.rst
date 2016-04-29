Domain Model
============

The domain model is actually pretty simple. We typically think most about the following entities:

User
----

People are core to the Zooniverse. When talking publically about the Zooniverse we almost always use the term ‘citizen scientist’ or ‘volunteer’ because it feels like an appropriate term for someone who donates their time to one of our projects. When writing code however, the shortest descriptive term that makes sense is usually selected so in our domain model the term we use is User.

A User is exactly what you’d expect, it’s a person, it has a bunch of information associated with it such as a username, an email address, information about which projects they’ve helped with and a host of other bits and bobs. Crucially though for us, a User is the same regardless of which project they’re working – that is Users are pan-Zooniverse. Whether you’re classiying galaxies over at Galaxy Zoo or identifying animals on Snapshot Serengeti we’re associating your efforts with the same User record each time which turns out to be useful for a whole bunch of reasons (more later).

Subject
-------

Just as people are core, as are the things that they’re analysing to help us do research. In Old Weather it’s a scanned image of a ship log book, in Planet Hunters it’s a light curve, whereas in Snapshot Serengeti it is a photograph of an animal. Regardless of the project, internally we call all of these things Subjects. A Subject is the thing that we present to a User when we want to them to do something.

Subjects are then stored in our database with a collection of metadata added from the manifest the user supplied while uploading. For example in Galaxy Zoo we might store some metadata associated with the survey telescope that imaged the galaxy and in Cyclone Center we store information about the date, time and position the image was recorded.

It is important to keep in mind that a Subject is not the same as an image. For some projects, Subjects will have multiple images that a User can cycle between. For others, a Subject will not be an image at all, but might have audio recordings, movies, or pieces of text instead. A Subject could also have multiple different media types at the same time.

Workflow
--------

The Workflow is another main entity in our system. It is where most of the parameters for a project are stored. Most importantly, the Workflow has the configuration of Tasks we ask our volunteers to perform when they are presented with a Subject. In Notes from Nature each step of the transcription (such as ‘What is the location?’) is a separate Task, in Galaxy Zoo, each step of the decision tree is a Task too. The Workflow also determines which Subjects are available to work on, and how long they should be worked on.

Classification
--------------

As a User is presented with a Subject and progresses through the Workflow, they produce a Classification. The Classification is the core unit of human effort produced by the Zooniverse community as it represents what a person saw and what they said about it. We collect a lot of these!

SubjectSet
----------

Sometimes we need to group Subjects together for some higher level function. Perhaps it’s to represent a season’s worth of images in Snapshot Serengeti or a particular cell dye staining in Cell Slider. Whatever the reason for grouping, the entity we use to describe this is ‘SubjectSet’. The assignment of Subjects to Workflows actually happens by assigning SubjectSets to workflows, because a project often has hunderds of thousands of Subjects and assigning each of those individually would be tedious to do by hand.

Project
-------

The Zooniverse APIs host a whole bunch of different Zooniverse projects so it’s probably no surprise that we represent the actual citizen science project within our domain model. No prize for guessing the name of this entity – it’s called Project. A Project is really just the overarching named entity that SubjectSets and Workflows are associated with.

Finally
-------

Our domain model has also been heavily influenced by the patterns that have emerged working with science teams. In the early years we spent a lot of time abstracting out each step of the User interaction with a Subject into distinct descriptive entities called Annotations. While in theory these were a more ‘complete’ description of what a User did, the science teams rarely used them and almost never in realtime operations. The vast majority of Zooniverse projects to date collect large numbers of Classifications that are write once, read very much later. Realising this has allowed us to worry less about exactly what we’re storing at a given time and focus on storing data structures that are a convenient for the scientists to work with.
