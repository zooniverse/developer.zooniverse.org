developer.zooniverse.org
========================

This repository hosts the source files for the [developer documentation](http://developer.zooniverse.org).

## Viewing locally

While editting, you'll probably want to view the resulting HTML before committing. Right now, to do this you
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
