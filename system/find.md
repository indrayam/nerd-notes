# find

`find . -name CredDB.CEF -exec /bin/rm -f '{}' \;` Removing CredDB>CEF files from Dropbox folders

`find . -name *.pdf -exec /bin/cp -f '{}' ~/eBooks/PDF/ \;` Copying all pdf files from a certain directory/sub-directory tree to a 'single' folder

`find . -name CVS -exec rm -rf {} \;` CVS hack for cleaning cvs folders recursively

`find . -mmin -5`

`find -type f -exec sh -c "file {} | grep text >/dev/null" \; -print` This is more powerful than `ls **/*(.)` cause that will also include binary files
