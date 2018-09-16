# tr

### convert upper case to lower case

`echo ABCDE | tr '[:upper:]' '[:lower:]'`

### How to search for a compliment of a pattern

Anything that is not character 'c', print 1 there

`echo AbcdE | tr -c 'c' '1'`

### Pull out patterns from a text

`echo AbcdEfGGHA | tr -dc '[:lower:]'`

### Remove repeated characters

`echo 'too    many    spaces  here' | tr -s '[:space:]'`


