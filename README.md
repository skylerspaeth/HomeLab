# HomeLab
This repo creates most of the services I deploy in my home network.

## Rancher Installation
To deploy all the HomeLab infrastructure from scratch, start by deploying Ubuntu Server 22 to baremetal. During setup use a static IP and tick the box to install OpenSSH server.
> **Warning**
> These docs are written for Rancher v2.7.1. It's possible that the process may be different in later versions of Rancher.

### Ugrade all packages
```bash
sudo apt-get update && sudo apt-get upgrade -y
```

### Install Docker
> **Note**
> Docker **MUST** be installed using this method instead of in the Ubuntu installer as it uses Snap. This causes problems down the line with Docker permissions.

```bash
curl -fsSL https://get.docker.com | sh
```

### Start Rancher Server
Since I'll be running the Rancher server (`rancher/rancher`) and its agent (`rancher/rancher-agent`) on the same node, I'll have to forward the HTTP/S ports to ones that don't conflict with the agent's ports. This is why I'm not using the standard 80 and 443 ports below.

Setup Rancher UI to run automatically on boot:
```bash
sudo docker run --privileged -d --restart=unless-stopped -p 8080:80 -p 8443:443 -v /opt/rancher:/var/lib/rancher rancher/rancher
```

Follow the setup process and get the bootstrap password:
```bash
sudo docker logs $(sudo docker ps | tail -n+2 | awk '{print $1}') 2>&1 | grep "Bootstrap Password:"
```

### Setup Rancher Agent
Once logged in, click "Create" to create a new cluster. Select custom. Optionally extend the NodePort range to include the default Minecraft port (25565). Check all node roles under "Node Options". `etcd`, `Control Plane`, and `Worker` are all three needed.

Copy the generated command and run it on the same node as the server. Wait a few minutes for the new cluster to come up.


### Remotely Manage the Cluster
By going to the cluster page, you can download a kubeconfig, then rename and move it to `~/.kube/config`.


## Rancher Configuration
Create a HomeLab Infra project with `minecraft` and `discord` namespaces inside it.

### WIP: Backup
In order to restore to an exact configuration:
```
# needs to go here
```

To make a backup, use the script [here](docs/RANCHER_BACKUP.md).

## Services:
The following services are **fully functional**:
- `discord`
- `musicbot`
- `media`
- `http`

The remaining services are in varying stages of **work in progress**:
- `minecraft`
- `csgo`

## Links:
- https://hub.docker.com/r/instantlinux/nut-upsd
- https://hub.docker.com/r/linuxserver/jellyfin
