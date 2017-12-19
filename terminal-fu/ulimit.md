# ulimit

[Source 1](https://stackoverflow.com/a/34645)

You could always try doing a `ulimit -n 2048`. This will only reset the limit for your current shell and the number you specify must not exceed the hard limit

Each operating system has a different hard limit setup in a configuration file. For instance, the hard open file limit on Solaris can be set on boot from /etc/system.

On OS X, this same data must be set in `/etc/sysctl.conf`:

```bash
set rlim_fd_max = 166384
set rlim_fd_cur = 8192
```

Under Linux, these settings are often in /etc/security/limits.conf:

```bash
kern.maxfilesperproc=166384
kern.maxfiles=8192
```

There are two kinds of limits:

- soft limits are simply the currently enforced limits
- hard limits mark the maximum value which cannot be exceeded by setting a soft limit

Soft limits could be set by any user while hard limits are changeable only by root. Limits are a property of a process. They are inherited when a child process is created so system-wide limits should be set during the system initialization in init scripts and user limits should be set during user login for example by using pam_limits.

There are often defaults set when the machine boots. So, even though you may reset your ulimit in an individual shell, you may find that it resets back to the previous value on reboot. You may want to grep your boot scripts for the existence ulimit commands if you want to change the default.

[Source 2](https://stackoverflow.com/a/923369)

If you are using Linux and you got the permission error, you will need to raise the allowed limit in the `/etc/limits.conf` or `/etc/security/limits.conf` file (where the file is located depends on your specific Linux distribution).

For example to allow anyone on the machine to raise their number of open files up to 10000 add the line to the limits.conf file.

`* hard nofile 10000`

Then logout and relogin to your system and you should be able to do:

`ulimit -n 10000`

without a permission error.

[Source 3](https://stackoverflow.com/questions/34588/how-do-i-change-the-number-of-open-files-limit-in-linux/34645#comment51642900_923369)

Wildcard **does not** apply to root user. You have to specify `root hard nofile 10000` if you want to adjust the root limit.

### My changes
I edited the `/etc/security/limits.d/` folder and added a file named `20-nofile.conf` with the following lines:

```bash
*          hard    nofile     10000
root       hard    nofile     10000
```

Saved the file. Logged out and logged back in.
