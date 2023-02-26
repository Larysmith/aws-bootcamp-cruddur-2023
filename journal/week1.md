# Week 1 — App Containerization


# **TASKS COMPLETED FOR WEEK 1**

1. CHECKLIST ASSIGNMENT
2. HOMEWORK CHALLENGE 
## **CHECKLIST ASSIGNMENT** 
1. Containerize the application
2.  Document the notification endpoint
3.  Write a flask endpoint for notification
4. Write a React Page for Notifications
5.  Run DynamoDB Local Container and ensure it works
6.  Run Postgres Container and ensure it works
### 1. **CONTAINERIZE THE APPLICATION** 
1. BACKEND
    * Add the [Backend Dockerfile](../backend-flask/Dockerfile) in the `./backend-flask` directory.

       * Build the container 
       ```sh
           docker build -t  backend-flask .
       ```
       * Run the container
       ```sh
           docker run --rm -p 4567:4567 -it -e FRONTEND_URL='*' -e BACKEND_URL='*' backend-flask
       ```
    ![img](/_docs/assets/img-wk-2/Build%20containers.png)

    * Verify the backend is running on the port in the browser
    ![img](/_docs/assets/img-wk-2/Docker%20backend%20run.png)

    * Check the backend image ruuning
    ```sh
        docker images
    ```
    ![img](/_docs/assets/img-wk-2/docker%20images.png)

 2. FRONTEND
    * Add the [Frontend Dockerfile](../frontend-react-js/Dockerfile) in the `./frontend-react-js` directory.

    * Run `npm i` in the directory above then build the container

    * Build the container 
    ```sh
        docker build -t  frontend-react-js .
    ```
    * Run the container
    ```sh
        docker run -p 3000:3000 -d frontend-react-js
    ```
    
    * Verify the frontend is running on the port in the browser
    ![img](/_docs/assets/img-wk-2/sign%20in%20page.png)

3. MULTIPLE CONTAINERS
   * Create a [docker-compose.yml](../docker-compose.yml) at the project root directory
   * Run the compose file
       ```sh
           docker compose up -d
       ```
   * Verify that the multiple containers are up and running from your browser;
       ![img](/_docs/assets/img-wk-2/frontend%20homepage.png)

### 2. **DOCUMENT THE NOTIFICATION ENDPOINT**
Add an endpoint for the notification tab in the [openapi-3.0.yml](../backend-flask/openapi-3.0.yml) file
```sh
/api/activities/notifications:
    get:
      description: 'Return a feed activity for people I follow'
      parameters: []
      responses:
        '200':
          description: returns an array of activities
          content:
            application/json:
              schema:
                type: array
                items:
                  $ref: '#/components/schemas/Activity'

```

![img](/_docs/assets/img-wk-2/api%20notifcation%20documentation.png)



### 3. **WRITE A FLASK ENDPOINT FOR NOTIFICATION**
Step1 : Update the  [app.py](../backend-flask/app.py) with the following codes
```sh
    @app.route("/api/activities/notifications", methods=['GET'])
def data_notifications():
  data = NotificationsActivities.run()
  return data, 200
```
```sh
from services.notifications_activities import *
```
Step2 : Create the [notifications_activities](../backend-flask/services/notifications_activities.py) file.



### 4. **WRITE A REACT PAGE FOR NOTIFICATIONS**
Step1 : Update the [App.js](../frontend-react-js/src/App.js) with the following codes
```sh
    path: "/notifications",
    element: <NotificationsFeedPage />
  },
```
```
import NotificationsFeedPage from './pages/NotificationsFeedPage.js';
```

Step2 : Create and the following files;
* [NotificationsFeedPage.css](../frontend-react-js/src/pages/NotificationsFeedPage.css)
* [NotificationsFeedPage.js](../frontend-react-js/src/pages/NotificationsFeedPage.js)

Step3 : Verify from the browser
![img](/_docs/assets/img-wk-2/notification%20frontend.png)

### 5. **RUN DYNAMODB ON THE LOCAL CONTAINER AND ENSURE IT WORKS**
Step1 : Lets integrate the following into our existing docker compose file
```sh
services:
  dynamodb-local:
    # https://stackoverflow.com/questions/67533058/persist-local-dynamodb-data-in-volumes-lack-permission-unable-to-open-databa
    # We needed to add user:root to get this working.
    user: root
    command: "-jar DynamoDBLocal.jar -sharedDb -dbPath ./data"
    image: "amazon/dynamodb-local:latest"
    container_name: dynamodb-local
    ports:
      - "8000:8000"
    volumes:
      - "./docker/dynamodb:/home/dynamodblocal/data"
    working_dir: /home/dynamodblocal

```
Volumes;
```sh
    volumes: 
        - "./docker/dynamodb:/home/dynamodblocal/data"
```
Step2 : Create a table
```sh
aws dynamodb create-table \
    --endpoint-url http://localhost:8000 \
    --table-name Music \
    --attribute-definitions \
        AttributeName=Artist,AttributeType=S \
        AttributeName=SongTitle,AttributeType=S \
    --key-schema AttributeName=Artist,KeyType=HASH AttributeName=SongTitle,KeyType=RANGE \
    --provisioned-throughput ReadCapacityUnits=1,WriteCapacityUnits=1 \
    --table-class STANDARD

```
Step3 : Create an item
```sh
aws dynamodb put-item \
    --endpoint-url http://localhost:8000 \
    --table-name Music \
    --item \
        '{"Artist": {"S": "No One You Know"}, "SongTitle": {"S": "Call Me Today"}, "AlbumTitle": {"S": "Somewhat Famous"}}' \
    --return-consumed-capacity TOTAL  
```
![img](/_docs/assets/img-wk-2/db%20items.png)

Step4 : List Records
```sh
aws dynamodb list-tables --endpoint-url http://localhost:8000
```
![img](/_docs/assets/img-wk-2/db%20tables.png)
Step5 : Get Records
```
aws dynamodb scan --table-name cruddur_cruds --query "Items" --endpoint-url http://localhost:8000
```

### 6. **RUN POSTGRES CONTAINER AND ENSURE IT WORKS**
Step1 : Lets integrate the following into our existing docker compose file;
```sh
services:
  db:
    image: postgres:13-alpine
    restart: always
    environment:
      - POSTGRES_USER=postgres
      - POSTGRES_PASSWORD=password
    ports:
      - '5432:5432'
    volumes: 
      - db:/var/lib/postgresql/data
volumes:
  db:
    driver: local

```
Step2 : To install the postgres client into Gitpod
```sh
  - name: postgres
    init: |
      curl -fsSL https://www.postgresql.org/media/keys/ACCC4CF8.asc|sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/postgresql.gpg
      echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" |sudo tee  /etc/apt/sources.list.d/pgdg.list
      sudo apt update
      sudo apt install -y postgresql-client-13 libpq-dev

```

step3 : Volumes
```sh
volumes: 
  - db:/var/lib/postgresql/data

volumes:
  db:
    driver: local
```

Step4 : Verify that postgres is well integrated
 ![img](/_docs/assets/img-wk-2/postgress%20terminal.png)
## **HOMEWORK CHALLENGE**
1. Run the dockerfile CMD as an external script
2. Push and tag a image to DockerHub
3. Use multi-stage building for a Dockerfile build
4. Implement a healthcheck in the V3 Docker compose file
5. Researched the best practices of Dockerfiles and implement it in your Dockerfile
6. Installed Docker on my localmachine and got the same containers running.
7. Launch an EC2 instance that has docker installed, and pull a container
### 1. **RUN THE DOCKERFILE CMD AS AN EXTERNAL SCRIPT**
Step1 : 
Backend
* Create a start.sh file
```sh
#!/bin/sh
python3 -m flask run --host=0.0.0.0 --port=4567

```
* Update the docker file
```sh
FROM python:3.10-slim-buster

WORKDIR /backend-flask

COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt

COPY . .

ENV FLASK_ENV=development

EXPOSE ${PORT}
CMD [ "sh", "start.sh" ]

```
Step2 : Frontend
* Create a `start.sh` file
```sh
#!/bin/bash

npm start

```
* Update the docker file
```sh
FROM node:16.18

ENV PORT=3000

COPY . /frontend-react-js
WORKDIR /frontend-react-js
RUN npm install
EXPOSE ${PORT}
CMD ["/bin/bash", "start.sh"]

```
Step3 : Then build the images and run the containers.
```sh
    docker compose up
```


***Thank you!!! See you next week.***
