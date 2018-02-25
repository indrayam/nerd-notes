# tar

### Store files into a tape or disk archive

tar -cvf file.tar folder/

### Restore files from a tape or disk archive

tar -xvf file.tar

### Store files into a tape or disk archive and gzip compress the archive

tar -cvzf file.tar.gz folder/

### Restore files from a tape or disk archive which has also been compressed using gzip

tar -xvzf file.tar.gz

### Restore files into a different directory than the current one

tar -xvzf file.tar.gz -C /path/to/different-folder/

