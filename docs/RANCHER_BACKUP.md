## Creating a Rancher Backup
To create a backup of your rancher configuration, you can use the following script:

**WARNING:** This script doesn't take differences in Docker-based Rancher into account.
I only created it to hackily and lazily make a backup without having to do all the substitutions manually.
It expects that you will **only have one Rancher container running** and that you'll validate the resulting tarball to ensure everything worked.
The "right" way to create backups is to follow Rancher's official documentation on the matter
[here](https://ranchermanager.docs.rancher.com/v2.6/how-to-guides/new-user-guides/backup-restore-and-disaster-recovery/back-up-docker-installed-rancher).

```bash
#!/bin/bash

DATE=$(date '+%m-%d-%y')
NAME=$(docker ps -a | awk '$2 == "rancher/rancher:latest" {print $NF}' | grep -v rancher-data-.* | head -n1)
VER=$(
  docker image inspect --format '{{json .ContainerConfig.Env}}' rancher/rancher |
  jq -r '.[] | select(startswith("CATTLE_SERVER_VERSION="))' | cut -d= -f2
)

docker stop $NAME
docker create --volumes-from $NAME --name rancher-data-$DATE rancher/rancher:latest
docker run  --volumes-from rancher-data-$DATE -v $PWD:/backup busybox tar pzcvf /backup/rancher-data-backup-$VER-$DATE.tar.gz /var/lib/rancher
docker container rm rancher-data-$DATE

# restart the server
docker start $NAME
```
