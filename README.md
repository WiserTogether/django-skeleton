your-project
=============

This is the default README for your project using the paas-skeleton. You should
modify it to reflect usage of your project. The paas-skeleton README file can be
found in .paas-skeleton/README.md


Deployment Instructions
-----------------------

To deploy an OpenShift instance of this skeleton with the Patton module, use
the following RHC incantation:

    rhc create-app -n namespace -f https://github.com/your/repo.git name-of-app http://pattoncdk-wisertogether.rhcloud.com/manifest/master

or, using the web interface, provide 

    http://pattoncdk-wisertogether.rhcloud.com/manifest/master

as the URL of the cartridge.


