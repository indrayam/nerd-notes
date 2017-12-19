# ansible

#### This is part of the ‘ping’ ansible module:
`ansible <host-alias> -m ping`

#### This is part of the ‘command’ ansible module and is not processed through the shell:
`ansible <host-alias> -a "unix command"`

#### This is part of the ’shell’ ansible module and is not processed through the shell:
`ansible <host-alias> -m shell -a "unix command"`

#### This is part of the ‘copy’ ansible module:
`ansible <host-alias> -m copy -a "src=<filepath> dest=<filepath>"`
