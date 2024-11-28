# Mac Notes

## Disable mds and mds_stored

Source: [mds and mds_stores constantly consuming cpu](https://apple.stackexchange.com/questions/144474/mds-and-mds-stores-constantly-consuming-cpu)
As you know, the mds and mds_stores are Spotlight activities.

The reason why your Spotlight is so active could be a number of things; it could be you have an app or multiple apps constantly changing some folder contents.

First let's check whether Spotlight is the cause of the fans running so much. To test this, run the following in your terminal:

`sudo mdutil -a -i off`
this turns off indexing of files, and should result in a clear slow down of the fans if mds and/or mds_stores are to blame.

To turn indexing back on, run

`sudo mdutil -a -i on`
After this you could run the complete re-indexing of your hard drive (be aware this could be an over night job), it will delete your Spotlight data base forcing it to start over.

`sudo rm -rf /.Spotlight-V100/*`
The next and final step would be to add others to your (do not scan), privacy settings.

`codesign -dvv /usr/libexec/routined`
To check if a binary is signed binary by Apple
