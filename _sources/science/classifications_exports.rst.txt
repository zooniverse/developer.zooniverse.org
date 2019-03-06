Dealing with classifications
============================

When you request an export of the raw classification data using the project builder, some of the columns
we return will actually contain values in a format called JSON. We do this, because sadly sometimes the
kinds of data we track are too complicated to easily fit into a table structure. However, using Python
it's actually really easy to pull out the data you need from those JSON-based columns::

    import pandas
    import json

    data = pandas.read_csv("classifications.csv")

    data["annotations"]  = data["annotations"].map(json.loads)
    data["metadata"]     = data["metadata"].map(json.loads)
    data["subject_data"] = data["subject_data"].map(json.loads)


This will turn those columns into a normal `Python dict`_. If you know your project has classifications pertaining
to a single subject at a time, you can make things even simpler with a further step::

    def flatten_subject_info(subject_data):
      result = subject_data.values()[0]
      result.update({'id': subject_data.keys()[0]})
      return result

    data["subject_data"] = data["subject_data"].map(flatten_subject_info)

.. note:: This example assumes you have installed the Python library called Pandas. Many scientific Python distributions
          include this library, but you can install this with `pip install pandas` otherwise.

.. todo:: expand

.. _Python dict: https://docs.python.org/2/library/stdtypes.html#mapping-types-dict
