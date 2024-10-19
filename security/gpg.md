# gpg2

- [Source](https://futureboy.us/pgp.html#GettingStarted)
- [How to use GPG on the command line](http://blog.ghostinthemachines.com/2015/03/01/how-to-use-gpg-command-line/)
- [Generating a new GPG key](https://help.github.com/en/articles/generating-a-new-gpg-key)
- [GPG Cheat Sheet](http://irtfweb.ifa.hawaii.edu/~lockhart/gpg/)
- [Fedora - Creating GPG Keys](https://docs.fedoraproject.org/en-US/quick-docs/create-gpg-keys/#:~:text=To%20find%20your%20GPG%20key,key%20ID%2C%20as%20in%200x6789ABCD%20.)
- [How to gpg sign a file without encryption](https://access.redhat.com/solutions/1541303)
- [Setup GPG on macOS](https://dev.to/zemse/setup-gpg-on-macos-2iib)
- [Migrate you GPG keys from One Machine to Another](https://blog.ridaeh.com/migrate-you-gpg-keys-from-one-machine-to-another-3341e980dfac)

GPG version 2 may be on your system with the executable name gpg2 . Either executable can be used for these demonstrations. Both are very compatible with each other. (If you want to know a million different opinions on which you should be using, do a web search.) Version 1 is more tested, and is usually a single monolithic executable. Version 2 is compiled with crypto libraries like libgcrypt externally linked, and is designed to work better with external password entry tools. That is, gpg2 is designed for graphical environments, while gpg works better for automated and command-line use. From the command-line, I use version 1.

## Install on MacOSX (test)

```bash
brew install gnupg
```

Connects gpg-agent to the OSX keychain via the brew-installed pinentry program from GPGtools. This is the OSX 'magic sauce', allowing the gpg key's passphrase to be stored in the login

# keychain, enabling automatic key signing.

```bash
brew install pinentry
brew install pinentry-mac
```

##

## Install on Ubuntu 16.04

```bash
# By default gpg 1.x is available on Ubuntu 16.04
sudo apt-get install gpg2
```

## Export and Import

```bash
# Export
gpg --export-secret-keys -a 2A30D3C45B5C792CC603C82AA190E97F52B7DBAC > anasharm_privatekey.asc
gpg --export -a 2A30D3C45B5C792CC603C82AA190E97F52B7DBAC > anasharm_publickey.asc
# Go to the new machine and import
gpg --import anasharm_privatekey.asc
gpg --import anasharm_publickey.asc
```

## Using GPG

```bash
# Command to list GPG keys for which you have both a public and private key. A private key is required for signing commits or tags:
gpg --list-keys --keyid-format LONG
gpg --list-keys A190E97F52B7DBAC
gpg -k
```

## Generating a GPG key

[Source](https://gitlab.com/help/user/project/repository/gpg_signed_commits/index.md)

1. Generate the private/public key pair with the following command, which will
   spawn a series of questions:

```bash
gpg --full-gen-key
```

2. The first question is which algorithm can be used. Select the kind you want
   or press `Enter` to choose the default (RSA and RSA):

```bash
Please select what kind of key you want:
   (1) RSA and RSA (default)
   (2) DSA and Elgamal
   (3) DSA (sign only)
   (4) RSA (sign only)
Your selection? 1
```

3. The next question is key length. We recommend you choose **4096**:

```bash
RSA keys may be between 1024 and 4096 bits long.
What keysize do you want? (2048) 4096
Requested keysize is 4096 bits
```

4. Specify the validity period of your key. This is something
   subjective, and you can use the default value, which is to never expire:

```bash
Please specify how long the key should be valid.
         0 = key does not expire
      <n>  = key expires in n days
      <n>w = key expires in n weeks
      <n>m = key expires in n months
      <n>y = key expires in n years
Key is valid for? (0) 0
Key does not expire at all
```

5. Confirm that the answers you gave were correct by typing **y**:

```bash
Is this correct? (y/N) y
```

6. Enter your real name, the email address to be associated with this key
   (should match a verified email address you use in GitLab) and an optional
   comment (press `Enter` to skip):

```bash
GnuPG needs to construct a user ID to identify your key.

Real name: Anand Sharma
Email address: anasharm@cisco.com
Comment:
You selected this USER-ID:
    "Anand Sharma <anand.sharma@gmail.com>"

Change (N)ame, (C)omment, (E)mail or (O)kay/(Q)uit? O
```

7. Pick a strong password when asked and type it twice to confirm.

8. Use the following command to list the private GPG key you just created:

```bash
gpg --list-secret-keys --keyid-format LONG --fingerprint anand.sharma@gmail.com
```

Replace <your_email> with the email address you entered above.

9. Copy the GPG key ID that starts with sec. In the following example, that's
   `30F2B65B9246B6CA`:

```bash
sec   rsa4096/30F2B65B9246B6CA 2017-08-18 [SC]
      D5E4F29F3275DC0CDA8FFC8730F2B65B9246B6CA
uid                   [ultimate] Anand Sharma <anasharm@cisco.com>
ssb   rsa4096/B7ABC0813E4028C0 2017-08-18 [E]
```

10. Export the public key of that ID (replace your key ID from the previous step):

```bash
gpg --armor --export 30F2B65B9246B6CA
```

## Associating your GPG key with Git

1. Use the following command to list the private GPG key you just created:

```bash
gpg --list-secret-keys --keyid-format LONG --fingerprint anasharm@cisco.com
```

Replace <your_email> with the email address you entered above.

2. Copy the GPG key ID that starts with `sec`. In the following example, that's `30F2B65B9246B6CA`:

```bash
sec   rsa4096/30F2B65B9246B6CA 2017-08-18 [SC]
      D5E4F29F3275DC0CDA8FFC8730F2B65B9246B6CA
uid                   [ultimate] Mr. Robot <your_email>
ssb   rsa4096/B7ABC0813E4028C0 2017-08-18 [E]
```

3. Tell Git to use that key to sign the commits:

```bash
git config --global user.signingkey 30F2B65B9246B6CA
```

Replace `30F2B65B9246B6CA` with your GPG key ID.

4. (Optional) If Git is using gpg and you get errors like secret key not available
   or gpg: signing failed: secret key not available, run the following command to
   change to gpg2:

```bash
git config --global gpg.program gpg2
```

5. Setup GPG, GPG Agent and PinEntry

[Source](https://gist.github.com/bmhatfield/cc21ec0a3a2df963bffa3c1f884b676b)

- Create `~/.gnupg/gpg.conf` with the following content:

```bash
# Uncomment within config (or add this line)
use-agent
```

- Create `~/.gnupg/gpg-agent.conf` with the following content:

```bash
# Connects gpg-agent to the OSX keychain via the brew-installed
# pinentry program from GPGtools. This is the OSX 'magic sauce',
# allowing the gpg key's passphrase to be stored in the login
# keychain, enabling automatic key signing.
pinentry-program /opt/homebrew/bin/pinentry-mac
```

- Change your Zsh shell script by adding the following excerpt

```bash
## GPG
# Source: https://gist.github.com/bmhatfield/cc21ec0a3a2df963bffa3c1f884b676b
# Add the following to your shell init to set up gpg-agent automatically for every shell
# In order for gpg to find gpg-agent, gpg-agent must be running, and there must be an env
# variable pointing GPG to the gpg-agent socket. This little script, which must be sourced
# in your shell's init script (ie, .bash_profile, .zshrc, whatever), will either start
# gpg-agent or set up the GPG_AGENT_INFO variable if it's already running.

# Add the following to your shell init to set up gpg-agent automatically for every shell
if [ -n "$(pgrep gpg-agent)" ]; then
    echo "GnuPG Agent is running"
else
    eval $(gpg-agent --daemon --default-cache-ttl 31536000)
fi
```

- Restart shell
- Login once from command-line. Enter Keyphrase. After that, it should be cached.

If you start getting the error `error gpg failed to sign the data`, run `killall gpg-agent`. Kill the terminal session. Log in again and run the following command to make sure things are ok: `echo "test" | gpg --clearsign`

If this test is successful (no error/output includes PGP signature), you have successfully resolved your issue. You should now be able to use git signing again!

Note: If a `git` command fails, run the command by appending `GIT_TRACE=1` in front of the command like the following:

```bash
GIT_TRACE=1 git commit -m "Add page that always requires a logged-in user"
```

Source: [gpg failed to sign the data fatal: failed to write commit object](https://stackoverflow.com/a/47561300/520901)

One more thing. Sometimes, these issues may occur because the GPG key itself has expired. If so, refer to this thread to extend the expiration.

Source: [Git error - gpg failed to sign data](https://stackoverflow.com/a/43728576/520901)

## Prints the GPG key ID, in ASCII armor format

```bash
gpg --armor --export A190E97F52B7DBAC

Copy your GPG key
-----BEGIN PGP PUBLIC KEY BLOCK-----
...
-----END PGP PUBLIC KEY BLOCK-----
```

## Edit a GPG Key (https://coderwall.com/p/tx_1-g/gpg-change-email-for-key-in-pgp-key-servers)

You cannot delete keys nor modify UIDs for keys uploaded to PGP key servers. To change your email, you must add a new UID.

```bash
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
```

## Send GPG Key to MIT Key Server

`gpg --keyserver hkp://pgp.mit.edu --send-keys <keyID>`

## Encrypt files using private GPG key

```bash
gpg -r "anand.sharma@gmail.com" --encrypt <file-name> # (generates a binary file with .gpg extension)
gpg -r "anand.sharma@gmail.com" --armor --encrypt <file-name> # (generates an ASCII file with .asc extension)
```

## Decrypt files using private GPG key

```bash
gpg --decrypt <file-name.gpg> > filename OR
gpg --decrypt <file-name.asc> > filename
```

## Kill gpg-agent

```bash
gpgconf --kill gpg-agent
```


