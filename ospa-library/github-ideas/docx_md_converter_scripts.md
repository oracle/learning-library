# **BETA** Scripts to convert .docx to .md **** [RETURN](README.md)

### Ale is working on a couple of Python scripts - NOTE: Currently BETA!
* One for Python 2  [converter_beta.py](https://raw.githubusercontent.com/jjking2019/ospa-github-ideas/master/files/converter_beta.py)
* One for Python 3  [converter_py37.py](https://raw.githubusercontent.com/jjking2019/ospa-github-ideas/master/files/converter_py37.py)

### How do I know which version of Python I have on my machine? (you might have both)

1. Open Terminal window on Mac; Command window on Windows (__"cmd" command__ NOT "command")

1. Issue following command to see if you are on python 2

   `python --version`

1. Issue following command to see if you are on python 3

   `python3 --version`

### Run the appropriate command from the command line

 `python converter_beta.py`

 `python3 converter_py37.py` <br/>
 *Note:This script has been refactored for Python 3.7. Please notify admins of any issues running on a different python 3 release.*

 ### You will see a dialog that looks like this:

  ![](images/PythonScriptForm.png)

1. Fill in complete file path to docx file (**Avoid using spaces on the file names**)<br/>
   
   PC
   C:\Users\Manatee\Documents\mymswordfile.docx
   
   Mac
   /Users/Manatee/Document/mymswordfile.docx

1. Fill in path for local git repo directory/folder
   (presumes you have 'cloned' Dev Repo)

   PC
   C:\Users\gitrepos\appDev

   Mac
   /Users/gitrepos/appDev

   You may change the name of the .md document created, defaults to .docx name
  
   "README" in example creates a "README.md" file (default GitHub display page)

  ![](images/PythonScriptFormFilled_v2.png)

1. Click "Enter" to convert .docx file to .md in chosen repo; you should see the following when complete

  ![](images/PythonScriptComplete.png)

### The converted .docx file will now be found in your local repository converted to .md with all GitHub formatting

* Mac users only: 
   * You still need to change all .tiff images to .png or .jpg that GitHub will recognize (batch tools work best)
   * You still need to modify the .md file to change the image suffixes from .tiff to .png or .jpg (whatever you created)

* Now you are ready to clean-up the document as desired, but, probably easiest to make changes in MS Word .docx file and repeat the process so that MS Word document is always accurate

