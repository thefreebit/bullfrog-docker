# BullFrog Central Docker Compose
BullFrog Central is the central collector for the BullFrog Artifactory APM. This docker-compose configuration will allow you to spin up Cassandra and the central collector.

### How to use this
* Checkout the [GitHub project][bullfrog-image-github]
* Go to the docker-compose directory
* (optionally) Edit the .env file to change
  * UI_EXPOSE_PORT - The port the UI is accessed from **(Defaults to 4000)**
  * AGENT_EXPOSE_PORT - The port the agents will use to communicate with the central collector **(Defaults to 8181)**
  * CASSANDRA_DATA_MOUNT - The location to mount the **(Defaults to the `cassandra-data` directory inside the docker-compose directory )**
* Run `docker-compose up -d`

### Issues
* You can report any issues with the image on [GitHub][github-image-repo-issues]
* You can report issues with the BullFrog Server itself in the [BullFrog GitHub][github-bullfrog-repo-issues]

License
----

Apache 2.0

[bullfrog-image]: <https://hub.docker.com/r/thefreebit/bullfrog-central>
[bullfrog-image-github]: <https://github.com/thefreebit/bullfrog-docker/tree/master>

      
