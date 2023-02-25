# HomeLab
This repo creates most of the services I deploy in my home network.

## Rancher Setup
To deploy all the HomeLab infrastructure from scratch, first start by deploying a baremetal Debian server.

Next, install Docker:
```bash
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg lsb-release
sudo mkdir -m 0755 -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

Then, setup Rancher to run automatically on boot:
```bash
sudo docker run --privileged -d --restart=unless-stopped -p 80:80 -p 443:443 rancher/rancher
```

You can access it from a browser over the network now. It will persist through reboots of the node.

By going to the cluster page, you can download a kubeconfig, then rename and move it to `~/.kube/config`.

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
