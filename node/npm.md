# npm

[Node Package Manager: Beginner's Guide](https://www.sitepoint.com/beginners-guide-node-package-manager/)<br/>
[npm Cheatsheet](http://blog.nodejitsu.com/npm-cheatsheet)<br/>
[Reference: Node Apps](https://github.com/nodeapps/http-server)

`npm update -g`

Update everything to the latest version

`npm ls`, `npm -g ls`, `npm -g ls --depth=0`

View details of all installed Node apps

`npm install -g <module name>`

npm installs packages into the install prefix at prefix/lib/node_modules and bins are installed in prefix/bin, Local mode is the default. Use --global or -g on any command to operate in global mode instead.

`npm install <module name>`

npm installs packages into the current project directory, which defaults to the current working directory. Packages are installed to ./node_modules, and bins are installed to ./node_modules/.bin

`npm root`, `npm bin`

Use the npm root command to see where modules go, and the npm bin command to see where executables go

`npm search hook.io`

Search for npm packages

`npm view hook.io`

View details of a npm package
