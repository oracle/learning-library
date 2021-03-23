# Redwood Hands-on-Lab/Workshop common files

## Contents of this folder

In order to make the transition to the new single TOC template a smooth one, we will support the two templates in parallel.

/css
  - style.css : the legacy style sheet for LiveLabs workshops - do not use this style sheet after 10/5/20
  - style.min.js : the current style sheet for LiveLabs workshops and supports the latest single TOC template
/js
  - main.js : the legacy JavaScript file that supports two TOC workshop templates - do not use this JS file after 10/5/20
  - main.min.js : the current JavaScript file that supports the single TOC template

/development
  /css : source files (unminified) of development versions of the CSS
  /js  : source files (unminified) of development versions of the JS

Please *DO NOT EDIT THESE FILES!*

The current index.html is located in the `sample-livelabs-templates` folder.

## Transitioning to the new template

To transition from the existing template look-and-feel to the new one, the following changes are required:

1. Modify your `manifest.json` file and add the title of your workshop from the old index.html:

    ```
    {
        "workshoptitle":"<title of your workshop>",  <==== add this line to your manifest
        "help": "livelabs-help-db_us@oracle.com", <==== add this line to provide a button that will generate an e-mail to the LiveLabs team for support
        "tutorials": [
    ```

2. Replace your current index.html with the `index.html` file in this directory.

*Before you make a pull request, please test your workshop using the new template using live-server.*
