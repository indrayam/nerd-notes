# DevSecOps (2019-2020)

## North Star

[Source: CD Vision](https://storage.googleapis.com/us-east-4-anand-files/misc-files/cd-vision.png)

![CD Vision](https://storage.googleapis.com/us-east-4-anand-files/misc-files/cd-vision.png)

[Source: CD Goals](https://storage.googleapis.com/us-east-4-anand-files/misc-files/cd-vision.png)

![CD Goals](https://storage.googleapis.com/us-east-4-anand-files/misc-files/cd-2020.png)


## CAST Executive Team's Expectations

- Simplify CD Pipeline
- Build a unified developer experience focusing on productivity and ease-of-use
- Build a unified support experience continuously empowered by case and CD data

## PI 11 (Q3 FY19) Stakeholder Expectations

- **Drive CD 2.0 Adoption**
    - Conduct HackITx in SJC, RTP and BGLR
    - Conduct CD 2.0 Hands-on webinar sessions in SJC, RTP and BGLR
    - Conduct targeted demos with teams
- **Deliver CDA Enhancements**
    - GIS Enhancements
    - Quality Enhancements to Eleanor's team
    - Release Readiness Enhancements to Mauro's team
    - Security Enhancements to InfoSec
    - CDGE Events in Release and Quality Analytics
- **Launch CDConsole MVP**

## FY19 Customer Escalations and Dates

- All CAE Customers:
    + Remove uDeploy Polling for Quay
    + Explore the possibility of using unique generic IDs for each toolchain in CD
- Commerce:
    + Explore, understand and fix Commerce Issues

## FY19 CD 2.0 Deliverables and Milestone Dates

- **_Feb 1st:_** **[Status: DONE]**
    + Chronos Data Collection, Aggregation and Externalization capabilities in Production
    + Cleanup existing Spinnaker Templates
    + Make sure New Templates do not create Webex Notification and CDA Notification steps
- **_Feb 14th:_** CRUD operation support for CD 2.0 in SDaaS
- **_Feb 18th:_** codectl 1.0
    + list
    + get
    + create
    + delete
    + open 
- **_Feb 22nd:_**
    + Spinnaker 1.12.x Upgrades to support HackITx
    + Scale testing of the 1.12.x with
        + 1000+ namespaces in 6 accounts
        + 1000 accounts in a deployment.
    + Scaling Spinnaker Accounts by removing the use of Secrets
        + Create secret for accounts with passwords (Since we are not using halyard to create secrets) and kubeconfig
        + Create a utility that creates new account YAML into clouddriver-local.yaml as well as related K8s files
        + Persist these files into Minio
        + Build logic to automatically import Spinnaker account data from Minio and persist them before clouddriver pod starts up!
    + Balancing CD 2.0 Onboarding Experience and need to restart Spinnaker Clouddriver to provision Spinnaker Accounts 
        + Continue to keep dedicated Spinnaker Accounts, one per CAE cluster
        + Add all CAE Projects (data captured in CDA) into each of 6 "Generic" Spinnaker Accounts
        + When creating a CD 2.0 Pipeline for a new CAE Project (one that does not exist in Spinnaker Generic account already), check if the request is for a "new" CAE project. If so, make sure we restart Spinnaker Clouddriver during the next cycle
        + Spinnaker Clouddriver restarts should ONLY happen twice a day synced with token refresh
        + Write a onetime script to convert the existing HalConfig Accounts/Namespace to dedicated Spinnaker Account in Minio
        + Setup Spinnaker Accounts with permissions that allow Developers to have full access to create Pipelines inside the Spinnaker Application
        + Setup Spinnaker Accounts with permissions that DO NOT allow Developers to have write access to edit Stage and/or Prod Pipelines inside the Spinnaker Application
        + Update the existing piplines to map the newly created Spinnaker accounts
- Cisco IT-wide CD 2.0 Hands-on Webinars:
    + SJC: **_March 4th_** (Deepesh)
    + RTP: **_March 6th_** (Sujatha)
    + BLR: **_March 7th_** (Virat)
- CD 2.0 HackITx Sessions:
    + RTP: **_March 12th_**
    + BLR: **_March 14th_**
    + SJC: **_March 19th_**
- **_April 27th (end of Q3):_**
    - Increase Spinnaker application priority(in ESP) from P6 to P1.
- Sujatha conducts detailed KT session to enable more individuals to run demos! **[Status: DONE]**
    - Deepesh
    - Virat
    - Sanjeev
    - Philip
    - Anand
    - Anil A
    - Deepa
    - Jayaraman
- HackITx Structure (**10:00 am** to **4:00 pm** localtime)
    - Arrive by 9:30. Sessions starts at 10:00 am
    - Kickoff (15 mins)
    - Guided tour of CD 2.0
    - Using CD 2.0 with their own Software/Container Repo/CAE Project
    - 2 Ice-breakers (~1:00 pm and/or ~3:00 pm)
    - Make the participants give realtime feedback!
- HackITx Deliverables
    - Finalize Logistics
    - Create two Webex Spaces (Beginner and Advanced) for Questions and/or Feedback
    - Create training documentation site which will be used for the "Guided Tour" portion of the HackITx experience [Owner: Hareesha, Jayajit and Deepesh]
    - Make sure teams comes with their CAE software that they would like to migrate to CD 2.0 as part of the RSVP messaging
    - Two Ice-breakers (15 mins) length where we deep-dive into specific CD 2.0 concepts and/or ask questions. Topics to consider:
        - jenkinsfile + groovy magic
        - spinnaker concepts (spinnaker accounts, spinnaker app and spinnaker pipelines)
        - codectl
        - dynamic configuration generation using helm template
    - Execute a dry-run with the interns in RTP and BGLR to get a handle on what works and what does not 
        - RTP (EST): **_Date: Mar 5th_**
        - BGL (IST): **_Date: Mar 5th_**
    - Offer Feedback Survey at the end

- Our team's participation in each theater
    - RTP: Anil A, Anand, Sujatha, Jaya, Sudheer, Philip, Arun, Gopi, Sahithi, Kaali
    - SJC: Arun, Anil A, Anand, Sujatha, Gopi, Hareesha, Henry, Parjinder, Shweta, Ankur, Vikas
    - BGLR: Deepesh, Virat, Sanjeev, Deepa, Sagnik, Anil K, Support Team (TechM+CapG)
- CD Pipeline should support private repos
- 

## FY19 Unified Developer Experience Deliverables and Milestone Dates

- **_Feb 15th:_** CDConsole Mockups Completed and Reviewed
- **_March 15th:_** CDHome Mockups Completed and Reviewed
- **_April 15th:_** 
    - Launch code.cisco.com, cdconsole.cisco.com and codectl.cisco.com all aligned with cdanalytics.cisco.com
    - No content on ICX. All content moved to code.cisco.com!
    - All apps in CAE using Kubernetes Best Practices
    - All apps using CD 2.0


## FY19 CD Value-added Apps Deliverables and Milestone Dates

**_Feb 19:_** 
- Tooltip for all of the metrics in CDA (Definition of the metrics & calculation behind it) **[Status: DONE]**
- Finetune CR Metric & Unit Testing Mindset
- Ignore Oracle ERP / PLSQL Softwares leveraging SVN towards CI Metrics Calculation
- View CDGE Audits in Quality Analytics

**_Mar 12:_** 
- Mockup for SOx report as a part of Release Analytics
- AVA summary widgets to provide details based on R rating instead of High, Medium & Low 
- CD Console soft launch with Policy Administration Point
- Finalize the strategy for generating software_id for softwares that are not part of CD Pipeline

**_Apr 2:_**  
- Fine tune Continuous Integration (CI) metric
- Production Deployment views of CR and CI Metrics in Release Analytics (Application that is actually deploying code into Production) 
- Increase visibility across all GIS assets - Custom API to support ESP 
- Generate reports for SOx as a part of Security Analytics

**_Apr 23:_** 
- CDA Data API for daily data load to SPC 
- (Analysis) Finalize Design to pull the CR metrics from Crucible(for SVN) & AppDB
- (Analysis) Approach for exceptions/exclusions
- Heighliner API integration - To Enable GIS developers to onboard with SCAVA embedded in their Jenkins job
- Support for Gitlab & Gitlab Runner

**_May 1:_** **STRETCH GOAL**
- Review the backup scripts for “ALL” MongoDB instances and test “restore” functionality, using one of the backups
- Experiment with Index(s) for message_store and software_events collections.
    + If this works as expected, then implement the Idexes for Daily Aggregation and Snapshot Collections to increase Query/API performance and which also helps in loading some of the UI Widgets faster in CDA.
- Document every single CDA Component with Dependencies and Runtime Infrastructure details at a minimum
- Remove ALL backup/copy collections from Production MongoDB Databases


## FY19 CD 2.0++ Deliverables and Milestone Dates

- Design simplified CD experience

## Product Backlog (FY19 and beyond)

### CD 1.0

**Scrum Master:** Kaali
**Technical Lead:** Madhava
**Core Team:** Madhava, Sudheer, Indus

- CD Infrastructure Inventory
    - Manually updated list of Compute, Network and Storage assets used to run CDS
    - Automate the data collection and build data APIs 
    - Visualize the Data

- Migrate CD Pipeline infra from Platform 2 to Platform 3
    - EP3
    - Git
    - SVN
    - Jenkins
    - Crucible
    - SonarQube
    - uDeploy/uRelease
    - AppDB

- Observability Improvements
    - Prometheus/Grafana Experience and Expertize
    - Implementing Monitoring for all CAE Software (read, Value-Added Apps on CAE)
    - Enabling CLIP Logging at an individual software in CAE

### CD 2.0

**Scrum Master:** Hareesha
**Technical Lead:** Gopi and Anil
**Core Team:** Anil, Virat, Sujatha, Jayaraman, Deepesh, Sanjeev, Deepa, Anil K and OpsMX

- Spinnaker Pipeline-as-Code
- Upgrade Artifactory to the latest to be able to support Helm Chart Repo, Docker Registry and Go Modules
- Purge the unused repos
- Merge gitscm APIs into cd-api
- Merge cd-api-rcdn, cd-api-alln etc. to cd-api
- Document support of Blue/Green Deployment Strategies


### CD Value-added Apps

**Scrum Master:** Kaali
**Technical Lead:** Kevin & Arun
**Core Team:** Kevin, Arun, Jayaraman, Alagappan, Rajesh, Manjusha, Sri Sruja, Sahithi

**CDA Enhancements**

- Global Infrastructure Services (Chuck Churchill)
    + Alternate for Red 'X' in CD Adoption for tool chain indication (US223255 - S4)
    + 3rd Party software exclusion in CDA (US223256)
    + View for technical leads similar to a Service Owner view (US223260)
    + Quality and Resource analytics to include results for automated DB performance testing (US225122)
    + Change LoC Added/Deleted to equal what Git says, separating out Moved lines (US225129)
    + Requirement defined from results of ‘single pane of glass’ for Service Owners in Tableau for SO's (US225132)
    + Heighliner API integration - Enable GIS developers to onboard with SCAVA embedded in their Jenkins job (US228030)
    + LTaaS integration on CDA (US228331)
    + BitBucket Plugin to support git push secrets check (GIS) 

- Release Management (Mauro Sousa & Sarwat Amina)
    + Reporting for SOX under 'Security Analytics'
    + Support for Non-IT applications in CDA

- Release
    + Invoke VtV API end point to send _post_ production deployment events
    
- Security (Hessel Heerbout & Mahesh Bang)
    + OSR for SCAVA (S4)
    + Open Source Scanning Integration 
    + CDGE Audits in Release Analytics
    + CSB(Continuous Security Buddy)- CI CD Pipeline
    + CSB(Continuous Security Buddy)- CAE Tenants
    + CSB(Continuous Security Buddy)- P3 Tenants
    + CSDL Compliance *

- Quality (Alice Saiki & Ravi Nistala)
    + Improve Quality Analytics UX by adding tooltip for each widget (S4)
    + Implement new calculation for CR (S4)
    + _Quality Analytics related items_

- Supply Chain
    + Implement the SCAVA & BAVA percentage logic based on eligible applications as opposed to total applications
    + Enable the BAVA vulnerability details based on the last scan instead of all the scans
    + DAVA Certification / DAVA Vulnerability Numbers Enablement
    + Stack Compliance Integration
    + Discrepancy - BAVA Certified in CDA but not certified in ESP
    + Ability to generate custom report 

- Enhancements defined by the Team
    + Number of Software should only account for those that are active in last 365 days
    + Show Runtime Environment Data
    + Pull in Docker Image Size Data
    + GitLab/CDA Integration
    + CDA Migration to CAE
    + Developer activity directly from Git Repo
    + CDA Documentation – Git Repo markdown files
    + CDA API / Pages Optimization release to Production

**CDGE Enhancements**

- Integration with uD (S4)
- Integrate CDGE Audits data with CDA Release Analytics (S4)
- Mock up of including Policy Adminstration Point CD Console (S4)
- Policy Administration Point in CD Console 
- Integration with Spinnaker
- Enabling CDGE command line using CoDE CTL

**VtV Enhancements**

- Integration with Jira
- VtV Migration to CAE
- VtV API's for SOX Reporting
- Implement SOX Control CAU4: Before release – back end detect change – if user story is approved by the appropriate person, if there is testing performed with no defects

### Software Engineering Excellence
**Scrum Master:** Hareesha
**Technical Lead:** Deepesh
**Core Team:** Deepesh, Sujatha, Jayaraman, Virat, Sanjeev, Deepa and Philip

- Run all CD Value-Added using CD 2.0 Pipeline. Using Spinnaker for non-CAE Apps is not required. However, integration with Custom Deployment API Endpoint is **[Jan]**
    - CD API/eWorkers
    - CDGE
    - codectl.cisco.com
    - cd2docs.cisco.com
    - cdconsole.cisco.com
    - cdhome.cisco.com
    
- Migrate the following assets to CAE **[Feb]**
    + CD User Experience
        - code.cisco.com
            - ICX Code pages
            - cd2docs.cisco.com
        - cdconsole.cisco.com
        - cdctl.cisco.com
        - cdanalytics.cisco.com
        
    + CD Data Plane
        - CD Provisioning API etc.
        - CDA API etc.
        - VtV API etc.
        - CDGE API etc.

-  Make sure the CAE implementation follows the following Kubernetes Native Best Practices
    - Basics: Setup CD 2.0 Pipeline for "all" software
    - Basics: Write Unit Tests with average test coverage (~80%)
    - Basics: No Blockers in any software written
    - Make sure Docker Image sizes are optimized (read, small) 
    - Replace SpringBoot YAML files with Kubernetes Secrets
    - Service Discovery. No hardcoding external DNS entries in YAML files
    - Explore use of Service Mesh for Traffic Control, Security and Observability


