# Redwood Hands-on-Lab/Workshop common template

## How to use the redwood-hol rendering engine
* Copy the manifest.json and index.html files from this folder into your project folder.
* Copy the content.md file from /templates/redwood-hol folder into your project folder.
* You can review the template as a sample using the rendering engine through [this link](https://oracle.github.io/learning-library/templates/redwood-hol/).
* Edit the manifest.json file:
    * Modify the title element - the title is displayed in a content menu on the right
    * Modify the filename to point to the Markdown file in your project folder. The path should be relative to the index.html file. For example, this workshop has two labs:

    ```
    {
        "tutorials": [
            {           
            "title": "Lab 100: Provision ADW and Get Started",
            "description": "Create and access an Autonomous Database Cloud Service",
            "filename": "./intro-provision/intro-provision.md"
            },
            {           
            "title": "Lab 200: Review Query Performance",
            "description": "Run sample queries against a 100 million row current data set and a six billion row historic data set.",
            "filename": "./review-query-performance/review-query-performance.md"
            }
        ]
    }
    ```
* You can test locally using any local HTTP server, for example, [simplehttpserver](https://www.npmjs.com/package/simplehttpserver), [http-server](https://www.npmjs.com/package/http-server), [live-server](https://www.npmjs.com/package/live-server) and others.
* When deployed to GitHub, provide your customers the link to a GitHub page (oracle.github.io) that includes the path to the index.html file in your project. For example [https://oracle.github.io/learning-library/data-management-library/security/data-safe/workshop](https://oracle.github.io/learning-library/data-management-library/security/data-safe/worksop).
