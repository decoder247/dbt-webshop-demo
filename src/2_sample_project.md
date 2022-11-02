# Sample Project

## The Webshop

The company you work at runs a very real webshop selling all kinds of different products. Its a live production service that has tons of customers browsing it and buying stuff throughout the day and night. In fact, it's doing so well that the business is finally starting to pay attention to it. They want to analyze the activity for various purposes, but have no clue how to tackle this. Thankfully , they just recently hired a *Data Rockstar*... that's you... and have made this your first task of creating this infrastructure.

While doing some research, you stumbled across a new tool on the scene called **DBT**. You briefly went through some of the high-level documentation to see if it can get the job done. However, even after the research you're still unsure if you are in the right place to handle this task. ... Well you did! This book will help introduce the core concepts of **DBT** that make it a must have tool for a variety of data related tasks. I can personally say that I WISH I had known about **DBT** at my first job. It would have saved hundreds of hours.

Without further ado, let's get into it!

## Pre-Requisite Setup

Since there is only 1 webshop and it currently lives in a production environment, we want to create our own local development copy. The steps to do that are:

1. Install [docker desktop](https://docs.docker.com/desktop/install/mac-install/)
2. Install kubectl - `brew install kubectl`
3. Register docker-desktop k8s cluster with kubectl (verify using vscode)
     - you can spin up a docker-desktop k8s cluster using the docker-desktop application
4. optional: k9s - `brew install derailed/k9s/k9s`

5. Clone this repo `git clone https://github.com/Xccelerated/dbt-training.git`
6. Ensure you have access to the webshop project
    - `ping 35.204.200.74`
    - `telnet 35.204.200.74 5432`
    - general access to -> [webshop infra](https://console.cloud.google.com/kubernetes/list/overview?authuser=0&organizationId=867379850962&project=webshop-343714&supportedpurview=project)
7. If all of the above checks out, run the deployment script
    - you should be at the base of this directory `./dbt-training`
    - run `scripts/deploy.sh`
      - you may need to make the script an executable `chmod +x scripts/deploy.sh`

If all went well, you should be able to connect to your local postgres copy of the webshop database at:

- `localhost:5432` if using a local database management tool like **DBeaver**
- `postgres-service.postgres.svc.cluster.local:5432` if using pgadmin which is available in your browser at `localhost:30001`

Additionally the database should have tables as well as data in those tables (exception for *basemodel*).

Congrats! The hard part is over, now for the fun stuff.
