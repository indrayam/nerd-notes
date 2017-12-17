# my notes on gpg2

[Source](https://futureboy.us/pgp.html#GettingStarted)
GPG version 2 may be on your system with the executable name gpg2 . Either executable can be used for these demonstrations. Both are very compatible with each other. (If you want to know a million different opinions on which you should be using, do a web search.) Version 1 is more tested, and is usually a single monolithic executable. Version 2 is compiled with crypto libraries like libgcrypt externally linked, and is designed to work better with external password entry tools. That is, gpg2 is designed for graphical environments, while gpg works better for automated and command-line use. From the command-line, I use version 1.


### Using GPG

```bash
Command to list GPG keys for which you have both a public and private key. A private key is required for signing commits or tags:
gpg --list-keys --keyid-format LONG
gpg --list-keys A190E97F52B7DBAC
gpg -k
```


### GPG and Git

```bash
[user]
    name = Anand Sharma
    email = anand.sharma@gmail.com
    signingkey = A1...C
[gpg]
    program = gpg

# Configure Git to use gpg
git config --global gpg.program gpg
git config --global user.signingkey A19...C
# To set your GPG signing key in Git, paste the text below, substituting in the GPG key ID you'd like to use. In this example, the GPG key ID is A1..C

```




// Generating a new GPG key
gpg --gen-key

// Prints the GPG key ID, in ASCII armor format
gpg --armor --export A190E97F52B7DBAC

Copy your GPG key
-----BEGIN PGP PUBLIC KEY BLOCK-----
...
-----END PGP PUBLIC KEY BLOCK-----

// Edit a GPG Key (https://coderwall.com/p/tx_1-g/gpg-change-email-for-key-in-pgp-key-servers)
You cannot delete keys nor modify UIDs for keys uploaded to PGP key servers. To change your email, you must add a new UID.
$ gpg --edit-key <keyID>
gpg> adduid
Real name: <name>
Email address: <email>
Comment: <comment>
Change (N)ame, (C)omment, (E)mail or (O)kay/(Q)uit? o
You need a passphrase to unlock the secret key for
user: "foo <foo@bar.com>"

Update the trust level of the new UID.
gpg> uid <new uid number>
gpg> trust
Your decision? 5
Do you really want to set this key to ultimate trust? (y/N) y
gpg> uid <new uid number>

Revoke the old UID.
gpg> uid <old uid number>
gpg> revuid
Really revoke this user ID? (y/N) y
Your decision? 4
Enter an optional description; end it with an empty line: <description>
Is this okay? (y/N) y

gpg> save
$ gpg --keyserver hkp://pgp.mit.edu --send-keys <keyID>

// Send GPG Key to MIT Key Server
$ gpg --keyserver hkp://pgp.mit.edu --send-keys <keyID>

// Encrypt files using private GPG key
gpg -r "anand.sharma@gmail.com” --encrypt <file-name> (generates a binary file with “.gpg” extension)
gpg -r "anand.sharma@gmail.com" --armor --encrypt <file-name> (generates an ASCII file with “.asc” extension)

// Decrypt files using private GPG key
gpg --decrypt <file-name.gpg> > filename OR
gpg --decrypt <file-name.asc> > filename
