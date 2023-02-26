## Creating a Rancher Backup
Unfortunately it doesn't appear Rancher has an easy text-based backup tool (that is to say, one that exports to YAML/XML/JSON), which isn't very GitOpsey.
An alternative way to make a configuration backup is to use something like the following script:

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

# stop the rancher server
docker stop $NAME

# create a data container from it
docker create --volumes-from $NAME --name rancher-data-$DATE rancher/rancher:latest

# create the backup tarball
docker run  --volumes-from rancher-data-$DATE -v $PWD:/backup busybox tar pzcvf /backup/rancher-data-backup-$VER-$DATE.tar.gz /var/lib/rancher

# delete data container
docker container rm rancher-data-$DATE

# restart the rancher server
docker start $NAME
```

After running this script, you should have a tarball formatted with the date and version of Rancher you're using in its name.
Information on how to restore from backups is in the root README for the repo.
