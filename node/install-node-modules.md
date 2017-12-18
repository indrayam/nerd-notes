# Install Node Modules for Hacking

```bash

#!/bin/bash
mkdir -p ~/workspace/node-apps/helloapp
cd ~/workspace/node-apps/helloapp
npm init
# Packge, Dependency Managers
sudo npm install -g yarn
sudo npm install -g npm
# Compiler
sudo npm install -g typescript
#npm install babel-cli --save-dev (Installed but had a lot of Errors when npm list command was run after the install)
# Static Analysis
sudo npm install -g jshint
# Testing frameworks
sudo npm install -g mocha
sudo npm install -g jest
sudo npm install -g jasmine
# Module Bundler
sudo npm install -g webpack
sudo npm install -g browserify
# Execute <command> either from local node_modules/.bin or from a central cache
sudo npm install -g npx
# Command-line tool to create Angular client-side app
sudo npm install --unsafe-perm -g @angular/cli
# Command-line tool to create React client-side app
sudo npm install -g create-react-app
npm install react react-dom --save
# Command-line tool to create Vue.js client-side app
sudo npm install -g vue-cli
npm install vue --save
# Web App Framework (and related ecosystem)
npm install express --save
sudo npm install -g express-generator
npm install express-session --save
npm install cookie-parser --save
npm install errorhandler --save
npm install body-parser --save
npm install superagent --save
# Rich Framework for building applications and services
npm install hapi --save
# Logger
npm install morgan --save
# Templates
npm install pug --save
npm install handlebars --save
# Date/Time
npm install luxon --save 
# Command line
npm install commander --save 
npm install minimist --save
# Integrate with MongoDB
npm install mongodb@^2.0 --save
npm install mongoskin --save
#npm install --save-dev babel-cli babel-preset-env

echo "Done!"
npm ls -g --depth=0
npm ls --depth=0
```
