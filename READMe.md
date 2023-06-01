## HOW TO USE THIS COMPOSE FILE:
* After cloning the repo locally, `cd` into the local repo, make a copy of the `.env.example` file and name it `.env`.
~~~~
cp .env.example .env
~~~~
* Open the `.env` file and enter the appropriate database credentials.
* Then when your `.env` file is ready, run:
~~~~
docker compose build && docker compose up -d
~~~~

The web server listen's on port 80 and forwards to the docker host's port 8090. So, to test the app, go to:
`http://url:8090` or `http://ipaddress:8090`
