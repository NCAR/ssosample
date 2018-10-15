# ssosample
Sample application for Spring SAML Authentication to ADFS

A few of notes:
This app includes a Metadata generator that can be accessed at http://appserver...:8080/ssosample/samlsecurity/metadata.  However, if you have no metadata file and keystore to start with, the application won't start.  You'll have to disable calls to these things to get the app to start and generate your file.
There are parameters in the pom file that are used in the security context XML
The passwords are kept in the maven settings file
It is configured to get the FederationMetadata.xml file dynamically, with code commented out for a local file
