#!/bin/sh

# Mount EBS for SonarQube data
sudo mkfs -t xfs ${sonarqube_data_device_name}
sudo mkdir ${sonarqube_data_directory}
sudo mount ${sonarqube_data_device_name} ${sonarqube_data_directory}

# Allow SonarQube/Elasticsearch to write to the mounted volume
sudo chmod 777 ${sonarqube_data_directory}

# Run SonarQube docker image
docker run -d \
    --name sonarqube \
    --stop-timeout 3600 \
    -v ${sonarqube_data_directory}:/opt/sonarqube/data \
    -p 9000:9000 \
    sonarqube
