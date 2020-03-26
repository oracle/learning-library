# Create local repository to work with Developer Repository ---- [RETURN](README.md)

If you want to work on the repo using Git and GitHub from a local copy on your machine; you will need a folder to represent your clone/fork of the repository 
<br/>(these instructions assume you have successfully downloaded and installed git on the local machine)

Steps to get a current copy of repo (ospa-github-ideas in this example)
<br/>(steps will be the same for other repos, just change the name)

1. Open Terminal window on Mac; Command window on Windows (__"cmd" command__ NOT "command")

1. I created a folder for local repositories called 'gitrepos'

    `# mkdir gitrepos`       
    **(You pick the folder name, nothing magic about this one)**

1. Change directory to folder created

    `# cd gitrepos `
     
1. Initialize the folder for git

    `# git init `

1. Clone current folder 
   **(Using "github-ideas" as "Developer Repository" in this example)**

     1. Get current Developer Repository (repo) url from github 
     1. Click "Clone or Download" Button (you may download a .zip if that's all you want)- URI will look something like this: https://github.com/jjking2019/github-ideas.git
     1. Copy url provided to clipboard

  1. Issue following command using url from clipboard to "clone" the dev repo from the cloud and make a local copy on your machine (change to the desired "Developer Repository" name)

     `# git clone https://github.com/jjking2019/github-ideas.git `

    (should see messages something like this: 
       Cloning into 'github-ideas'...
       /* more messages here */ 
       ... done.)

1. Repository is cloned and may be worked on locally then 'committed' and 'pushed' to cloud
