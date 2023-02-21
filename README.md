# DevOps - Containerization, CI/CD &amp; Monitoring - January 2023 - SoftUni

## Advanced Containerization with Docker

The whole process is automated

1. Creating Vagrantfile which creates a docker swarm with 3 cluster nodes with the following configuration:
   - Box: "shekeriev/centos-stream-9"
   - Host names: "docker1.martin.bg", "docker2.martin.bg", "docker3.martin.bg"
   - Private network with dedicated IPs: "192.168.34.111", "192.168.34.112", "192.168.34.113"
   - Forwarded port - "guest:host": "8080:8080"
   - Provisioning via provided bash scripts: "setup-hosts.sh", "setup-docker.sh", "setup-additional-packages.sh", "setup-firewall.sh", "setup-needed-files.sh" and "setup-manager-node.sh" - for the master node, respectively "setup-worker-node.sh" - for each of the two workers
    - Shared folder settings: "/shared" folder from host is shared to "/vagrant" on the guests
    - Set virtual machine memory size use: 1536
    - Create after trigger event to deploy stack configuration on docker1 host with the docker-compose.yaml settings from shared folder
2. Creating custom docker images from provided files at /images folder:
   - web server: [Dockerfile.web](/images/Dockerfile.web)
   - db server: [Dockerfile.db](/images/Dockerfile.db)
   - resources for successfully building the images can be be found at this GitHub [repo](https://github.com/mark79-github/bgapp.git)
3. Uploding created docker images to <https://hub.docker.com/>
   - web : [mark79/web:demo](https://hub.docker.com/r/mark79/web)
   - db : [mark79/db:demo](https://hub.docker.com/r/mark79/db)
4. Creating-docker compose file:
   - filename: [docker-compose.yaml](/shared/docker-compose.yaml)
   - location: "/shared" folder, can be accessed from VMs
   - networks: "app-network"
   - secrets - docker secrets resource: "db-root-password"
   - services:
     - web:
       - image : mark79/web:demo
       - replicas: 3
       - forwarded port: expose port 80 from the web server to port 8080
       - shared volume configuration
       - network : app-network
     - db:
       - image : mark79/db:demo
       - environment variable for database password is readed from docker secret resource file: MYSQL_ROOT_PASSWORD_FILE
