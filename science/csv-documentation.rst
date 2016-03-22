

# You've got data!

**The four types of data outputs**
1. Subjects
2. Classifications
3. Workflow content
4. Workflow data

Note that all of these data outputs are technically csv files, but typically include JSON formatted fields inside the csv. Fields returned as JSON are indicated here with {json} after the field name.

## Subject data
**subject_id** - A unique Zooniverse-assigned identifier for the subject you uploaded. You can access the subject's unique Talk page by appending it to Talk URLS as such:  https://www.zooniverse.org/projects/vrooje/kitteh-zoo/talk/subjects/458025 (for subject 458025).

**project_id**    - A unique Zooniverse-assigned project identifier. Note that whereas project ascii names such as Kitteh Zoo or Planet Four can be duplicated across projects, these project_id numbers are unique. All project-specific data in the  Zooniverse database is tracked by this number. You can find the project id number in the top right corner of the project builder above the Project details button in the navigation bar.

**workflow_ids**    - Each workflow has a unique ID. This column tells you what workflow(s) *in this project* this given subject is associated with.  For example, [] indicates that this subject is not associated with any workflow;[123] means this subject is associated with workflow # 123;  [123, 456] indicates this subject is associated with workflows  none, otherwise you'll see a number between the two brackets. You can find the workflow ids for your project be viewing each workflow in the project builder.

**subject_set_id** - column lists the subject_set the given subject is currently associated with. You can find the subject_set id listed on each subject set page next to where the ascii name is.

**metadata** {json} - Contains all the information that was present in the manifest file during upload for this subject.

**locations**    {json} - Contains the web urls  for all images that make up a single subject so that the images can be downloaded or seen directly by the researcher

**classifications_by_workflow** {json} - tells you the classification count for each workflow the subject is associated with. format is in json as {workflow_id:  number of classifications} example" {"488":20} means there are 20 classifications already made for this subject in workflow_id 488

**retired_in_workflow** - If the subject is not retired in any workflows then you'll see empty brackets [] otherwise you'll see within the brackets the workflow_id numbers for which the subject already has classifications above the retirement limit so you can track the progress of your project.

## Classification data
This file describes the format of the classification file exports from the Zooniverse Project Builder. Each row of the file is a single classification. It records the choices and markings of one user for one workflow for one subject. The field/column names are explained here.

user_name (string) - The username of the person doing the classification

user_id (integer) - A unique ID corresponding to the user_name

user_ip (40-character hex string) - *** what is this exactly? a hash of something? of what? ***

workflow_id (integer) - A unique ID for the workflow done

workflow_name (string) - The text name of the workflow done

workflow_version (2 integers separated by '.') - The first integer represents the 'major' version and the second represents the 'minor' version. When tasks are changed (added, removed, etc.), the major version increments and the minor version is set to zero. *** Is this true? *** When just wording is changed, the minor version increments.

created_at (datetime in format YYYY-MM-DD HH:MM:SS UTC) - The time the classification is recorded in the Zooniverse database

gold_standard (***format?***) - *** I don't know what goes here, as I haven't done any gold yet; it's always blank in my exports. Help? ***

expert (***format?***) - *** I don't know what goes here, as I haven't done any expert yet; it's always blank in my exports. Help? ***

metadata (JSON formatted string) - Information about the user's interface and the classification itself

annotations (JSON formatted string) - The content of the user's classification

subject_data (JSON formatted string) - Information about the subject shown to the user

within subject_data
The first unlabeled integer is unique subject ID. Most of the rest of the JSON is the metadata for the subject, as uploaded by the project creator. The exception is the field 'retired' which is either 'null' or a JSON string describing the subject's retirement:

id (integer) - *** what is this?? ***

set_member_subject_id (***format? mine are all 'null'***) - *** what is this?? ***

workflow_id (integer) - The workflow for which this subject was retired

classification_count (integer) - The number of classifications this subject has received *** wouldn't it be nice to have the classification count even if a subject hadn't retired yet?! ***

created_at (datetime in format YYYY-MM-DDTHH:MM:SS.SSSZ ***in zulu time?!? Maybe better to have in same format as 'created_at'***) - *** what is this exactly? the time of the first classification as provided by the first user's browser? or is it the database time for the first classification? Or the time the subject was uploaded? Or something else? ***

updated_at (datetime in format YYYY-MM-DDTHH:MM:SS.SSSZ ***in zulu time?!? Maybe better to have in same format as 'created_at'***) - *** what is this exactly? Seems to match 'retired_at'. When would it not match 'retired_at'? ***

retired_at (datetime in format YYYY-MM-DDTHH:MM:SS.SSSZ ***in zulu time?!? Maybe better to have in same format as 'created_at'***) - The time at which *** um, what? The last user clicked 'done'? The time the database calculated retirement? ***

subject_id (integer) - *** kinda redundant to report this here, no? ***

within metadata


started_at (datetime in format YYYY-MM-DDTHH:MM:SS.SSSZ ***in zulu time?!? Maybe better to have in same format as 'created_at'***) - The time, as recorded by the user's browser ***true?***, that the subject was displayed to the user *** what timezone? user's local? ***

finished_at (datetime in format YYYY-MM-DDTHH:MM:SS.SSSZ ***in zulu time?!? Maybe better to have in same format as 'created_at'***) - The time, as recorded by the user's browser ***true?***, that the user clicked the 'Done' button *** what timezone? user's local? ***

user_agent (string) - The browser and operating system model and version  *** is that it, or is there more info in there? Is it provided by the browser? And how am I supposed to interpret something like "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.134 Safari/537.36" ?? ***

utc_offset (integer) - The offset from UTC time in seconds *** true? *** of the user's browser

user_language (string) - The language in which the user completed the classification, abbreviated. Currently only 'en' for English is supported. *** true? ***

viewport (two integers labeled 'width' and 'height') - The dimensions of the viewport on the user's device, i.e. the full size of the area where the subject can be presented. *** Is this right?? ***

subject_dimensions (four integers labeled 'clientWidth', 'clientHeight', 'naturalWidth', 'naturalHeight') - The 'natural' size of the subject is the subject's dimensions, in pixels, as uploaded. The 'client' size of the subject is the dimensions, in pixels, that the subject was seen at by the user. *** is this right?? ***


within annotations

task (string) - the name of each task as provided by the project creator

task_label (string) - the question for each task as it was shown to the user. *** does this value change in the export if the user has changed languages?! ***

value (string) - the answer for each task as provided by the user



for drawing tasks

tool (integer) - a unique ID for the drawing tool used for a given task

tool_label (string) - the label of the drawing tool used as seen by the user

frame (integer) - *** I don't know what this is! ***

for polygons
closed (true/false) - True if the user-drawn polygon was closed. False otherwise.

points (JSON formatted string) - A list of the points the user drew in (x,y) coordinate format, with each x and y value as real numbers. x and y values are pixel values relative to ***??? to what? the natural dimensions of the subject? or the client dimensions? or the viewport? And using what origin?? upper left? lower left? ***

for points
x (float) - the horizontal value of the point as a real number relative to *** what? *** using the ***upper/lower?*** left corner as the origin

y (float) - the vertical value of the point as a real number relative to *** what? *** using the ***upper/lower?*** left corner as the origin

*** Note that I only have data for drawing tasks using polygon and point tools. So I don't know what the data looks like for other types of drawing tools and they aren't represented here! ***
> Written with [StackEdit](https://stackedit.io/).
