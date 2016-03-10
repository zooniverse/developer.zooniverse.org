developer.zooniverse.org
========================

This repository hosts the source files for the [developer documentation](http://developer.zooniverse.org).

## How to make edits

The first thing to note is that the files are written in [reStructuredText](http://docutils.sourceforge.net/rst.html). 
This is not fully visible in Github's WYSIWYG view, you will need to view the Raw version of the `.rst` files to see 
everything, or else edit the files directly.

The best way to make edits is to fork this repository, clone the fork, make changes locally, test them using the method 
below, then when you are happy, submit a pull request. Once the PR is approved and merged, the changes will automatically 
be deployed to `developer.zooniverse.org`.

To add a new `.rst` file, simply create it in the appropriate directory, then add it to the table of contents.

## Viewing locally

While editing, you'll probably want to view the resulting HTML before committing. Right now, to do this you
will need both Python and Ruby installed, and then install the following dependencies:

```
pip install sphinx
gem install rerun
```

Then you can automatically run the HTML generation using:

```
rerun -x -p "**/*.{py,rst,png}" -- make html
```

Open the `_build/html/index.html` page in a browser.
