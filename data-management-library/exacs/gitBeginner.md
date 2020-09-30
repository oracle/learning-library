# Introduction to Git and GitHub

Git is version-control system (VCS) for working on group project
collaboration. It is a system making it possible for multiple persons
(DBA’s, programmers, project managers, testers, content providers, and
whomever else is on the team) to collaborate on a single project. It
also allows everyone to push and pull changes from a central repository
and work independently, then merge their work to deliver a final product
when ready. Git is probably the most widely used VCS. It is also
essential for using [GitHub](https://github.com/), which is the most
popular public website and platform for hosting and sharing projects.
It’s not the same as git — it’s a hub for projects that use git
version control.

We will use GitHub for the lab exercise.

### See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like us to follow up with you, enter your email in the *Feedback Comments* section.
## Tasks:

### **Task 1. Sign up for an account on GitHub**

Point your browser to https://github.com/ and select “Sign up” button on the right top of the page.
It is completely free to create and use a GitHub account. All you need
is an email address.

Your GitHub account will now exist as [https://github.com/yourUserName](https://github.com/yourUserName).
You will need to send the name to the instructor to get
authorization to access some source code for the lab exercise.

### **Task 2. Download git**

Click to download and install git for your [Mac](http://git-scm.com/download/mac)
[OS](http://git-scm.com/download/mac),
[Linux](http://git-scm.com/book/en/Getting-Started-Installing-git) or
[Windows](http://msysgit.github.io/) system.

### **Task 3. Open Terminal**

* Terminal is native to Linux users so you already know what to do.
* For Mac users, it’s Finder -> Applications -> Utilities ->
Terminal.
* Windows, search Git Bash that should be installed from the previous
step.

### **Task 4. Personalize git for yourself**

Now it is time to configure your name and email. Do this by typing in
the following, of course replacing the values with your user name and
email from Task 1.

```
<copy>git config --global user.name 'My_Name'
git config --global user.email 'myEmail@wherever.com'</copy>
```

### **Task 5. Clone a repository**

In this step, you will download/copy a repository from github. It is
crucial to work from a copy, particularly in a group collaboration! If
your work goes well, you save everything as you go (that will be our
next step). Ultimately, all the changes/additions you just made get
added back to the original repository, and that becomes the current
version. Meanwhile, other people are doing the same thing in their own
copied versions, which quickly become different from your copied
version.

The beauty of git is that it keeps track of all this stuff for you — who
has changed what where — and orchestrates it all.

So copy — or clone, in git-speak — your repo by running the command
“$https://github.com/albertyckwok/ecs-workshop-osc.git”

### **Task 6. Check status**

You can check the current status of your repository, by cd (Change
Directory) to your repository, e.g. cd \~/ecs-workshop-osc then type
“git status”:
