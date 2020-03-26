### Three-Level Rationale  ---- [RETURN](README.md)

* In GitHub (and Git) a "clone" or "fork" is of the entire repository; so, an OSPA clone of the Oracle learning-library contains everything in the 'master' repository
  * If someone makes changes to the clone or fork; those changes are made to the master when repositories are merged
  * If someone in OSPA inadvertently changes something in another team's folder it might be months before the mistake is noticed (probably not a good thing for OSPA)
* One of the reasons for adopting GitHub is to promote the free and rapid collaboration that Git is famous for
* So we are suggesting a three-level repository scheme that will require some manual (or scripted) steps by the admins
  * The oracle/learning-library repository will be our "Production Repository"; only accessible to Admins (https://github.com/oracle/learning-library)
  * The "Staging Repository" will be managed by the Admins; it will be a clone of oracle/learning-library 
<br/>(currently using https://github.com/jjking2019/learning-library)
  * Developers will use one (or more) "Developer Repository" 
    * Each "Developer Repository" contains a single folder e.g. appint contains the appint folder's contents
    * Developers will have full rights to add, modify, delete "Developer Repository" contents
    * Developers may include anyone they like (as long as they are GitHub users) to contribute and collaborate
    * Developers (and their teams) will perform all necessary CE and QA of the content
    * Our "Staging Repository" and "Production Repository" will not contain data from the "Developer Repository", instead, they contain "pointers" to the current version of the "Developer Repository"; developers may ONLY modify developer repositories they have been added to; they may not alter anything else
  * Current plan is for Admins to run a script to update the "pointer" in the "Staging Repository" when developers advise them they are ready to test
  * Using a "Staging Repository" allows developers to verify that the content is correctly posted
  * Once the developer lets Admins know all is good, we can request that the "Production Repository" be updated to point to the new version


  ## Alternative Mechanism (not selected)
* Two-level OSPA repository (repo) scheme
   1. Oracle Learning-Library (production)
   1. OSPA Learning-Library (staging)
* Developers create .zip file for desired folder and make it available to "Admins" for unzip and load. Zip file will be shared using email, LCMS, or Slack (go-ospa-github). - WCGW? :pray:
* Developer GitHub access is not required
