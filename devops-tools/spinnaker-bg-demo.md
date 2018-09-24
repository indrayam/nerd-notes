# Spinnaker Blue/Green Demo

### Cmd Reference  

```bash
while true; do curl -s https://helloclouddemo-bg.cisco.com/version | jq . ; done
watch -n 2 kubectl --context=cae-prd-rcdn-hcn get pods -o wide -l app=hcnd-web-app-bg-blue
watch -n 2 kubectl --context=cae-prd-rcdn-hcn get pods -o wide -l app=hcnd-web-app-bg-green
watch -n 2 kubectl --context=cae-prd-rcdn-hcn get svc -l app=hcnd-web-app-bg -o wide
```


### iTerm2 setup

1. Open 3 Tabs in the iTerm2
2. First one will be for running the HTTP Ping. Second one will be split into 3 horizontal panes to be used for Running the Kubernetes commands. The third one will be split into 2 horizontal panes, one for commands in the `$HOME/cnt-demo/hcnd-web-app-bg` folder and the other for commands in `$HOME/cnt-demo/hcnd-web-app-multi-cloud` folder

**Steps in iTerm2 (1st tab):**

Run the HTTP Ping command:

```bash
while true; do curl -s https://helloclouddemo-bg.cisco.com/version | jq . ; done
```

**Steps in iTerm2 (2nd tab):**

In the 1st sub-window, run this:

```bash
watch -n 2 kubectl --context='cae-prd-rcdn-hcn' get pods -o wide -l app=hcnd-web-app-bg-blue
```

In the 2nd sub-window, run this:

```bash
watch -n 2 kubectl --context=cae-prd-rcdn-hcn get pods -o wide -l app=hcnd-web-app-bg-green
```

In the 3rd sub-window, run this:

```bash
watch -n 2 kubectl --context=cae-prd-rcdn-hcn get svc -l app=hcnd-web-app-bg -o wide
```

### Blue/Green Demo Pre-requisite Steps:

1. Open the browser bookmarks for Blue/Green in a new Chrome window
2. In the 3rd tab's 1st sub-window of iTerm2, `cd` into `$HOME/cnt-demo/hcnd-web-app-bg`
3. Run `code .`
4. Make the following changes:
    - Color in `cover.css` to green (assuming blue is running)
    - Change `values.yml` file
    - Change the "Hola" text in `index.html` to show a difference
5. Go to the 3rd tab in iTerm2
6. Run `make`
7. Git commit (after adding to Stage)
8. Git Push

### Multi-Cloud Demo Pre-requisite Steps:

1. Open the browser bookmarks for Multi-Cloud in a new Chrome window
2. In the 3rd tab's 2nd sub-window of iTerm2, `cd` into `$HOME/cnt-demo/hcnd-web-app-multi-cloud`
3. Run `code .`
4. Make any text change in `index.html` so that you can kickstart the CI pipeline
5. Git commit (after adding to Stage)
6. Git Push


### Script for the actual presentation:

1. Start with PowerPoint
2. Once the PowerPoint slides are complete, switch to the Blue/Green Chrome window
3. Start with showing the current app that is running, highlight the version at the bottom
4. Switch to the iTerm2's 1st tab and show the simulation of an external "actor" using the app
5. [OPTIONAL] Show them the 2nd tab and show them the compute (pod) and service setup currently in Production
6. Switch back to Chrome and show them the Spinnaker Pipeline and talk about its strengths
7. Click on "Start Deployment" to kickstart the deployment
8. Talk about the capabilities of the pipeline until the "Continue Deployment?" manual judgment task prompts. Click Continue and then switch over to the iTerm2 to show the switch from "blue" to "green" without any errors
9. Take them to the Chrome to show that the new version of the App is LIVE!
11. Perform a Rollback
12. Take them to iTerm2 to show that the version switched back to the older version
13. Take them to the browser to show that the "blue" version is LIVE again!


1. Switch to the Multi-Cloud Spinnaker Pipeline Page
2. Show them the current version that is in Production across 4 clusters
3. Kickstart the Pipeline and wait till they all get deployed
4. Show them that the deployment went across all 4 clusters 





