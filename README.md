developer.zooniverse.org
========================

## TAKE HEED

The default and main branch on this repo is `source`. This is because Github Pages insists that the `master` branch is to be deployed and served if the repository is an organization pages one.

## TAKE HEED ABOVE

This repository hosts the source files for the [developer documentation](http://developer.zooniverse.org).

## How to make edits

The first thing to note is that the files are written in [reStructuredText](http://docutils.sourceforge.net/rst.html). 
This is not fully visible in Github's WYSIWYG view, you will need to view the Raw version of the `.rst` files to see 
everything, or else edit the files directly. You may find [this online reStructuredText editor](http://rst.ninjs.org/) and this [syntax primer](http://docutils.sourceforge.net/docs/user/rst/quickstart.html) useful.

The best way to make edits is to fork this repository, clone the fork, make changes locally, test them using the method 
below, then when you are happy, submit a pull request. Once the PR is approved and merged, the changes will automatically 
be deployed to `developer.zooniverse.org`.

To add a new `.rst` file, simply create it in the appropriate directory, then add it to the table of contents which 
is `index.rst` in the base directory.

## Viewing locally

While editing, you'll probably want to view the resulting HTML before committing. Right now, to do this you
will need both Python and Ruby installed, and then install the following dependencies:

```
pip install -r requirements.txt
gem install rerun
```

Then you can automatically run the HTML generation using:

```
rerun -x -p "**/*.{py,rst,png}" -- make html
```

Open the `_build/html/index.html` page in a browser.
