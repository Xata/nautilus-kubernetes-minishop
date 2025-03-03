# nautilus-demo-website
Hello and welcome to the nautilus-demo-website repository! The goal of this project is to provide a simple (and I mean SIMPLE) website for students to check to see if their infrastructure is working.
This is a simple static webpage that displays an image of a nautilus. 

![GitHub commit activity](https://img.shields.io/github/commit-activity/t/Xata/nautilus-demo-website?style=for-the-badge)
![GitHub top language](https://img.shields.io/github/languages/top/Xata/nautilus-demo-website?style=for-the-badge)
![GitHub repo size](https://img.shields.io/github/repo-size/Xata/nautilus-demo-website?style=for-the-badge)

## About this project

This is a simple static webpage that displays a nautilus upon visiting the site. This is used to check to make sure if your infrastructure has been setup and is working correctly.
It also contains the steps taken during the Kubernetes MiniShop #1 at MSU Denver.

## Kubernetes MiniShop #1 Steps
Below are the instructions for the kubernetes MiniShop.

### Host prep
Below are the steps you'll use to setup a Debian VM:

1. Harden SSH
   ```zsh
   sudo sed --in-place 's/^PermitRootLogin.*/PermitRootLogin no/g' /etc/ssh/sshd_config
   sudo sed --in-place 's/^#Port.*/Port 22/g' /etc/ssh/sshd_config
   sudo sed --in-place 's/^PasswordAuthentication.*/PasswordAuthentication yes/g' /etc/ssh/sshd_config
   sudo sed --in-place 's/^#AddressFamily.*/AddressFamily inet/g' /etc/ssh/sshd_config
   sudo sed --in-place 's/^#MaxAuthTries.*/MaxAuthTries 5/g' /etc/ssh/sshd_config
   sudo sed --in-place 's/^#MaxSessions.*/MaxSessions 2/g' /etc/ssh/sshd_config
   sudo sed --in-place 's/^#LoginGraceTime.*/LoginGraceTime 60/g' /etc/ssh/sshd_config
   sudo sed --in-place 's/^#LogLevel.*/LogLevel VERBOSE/g' /etc/ssh/sshd_config
   sudo sed --in-place 's/^#Compression.*/Compression no/g' /etc/ssh/sshd_config
   sudo sed --in-place 's/^#PermitEmptyPasswords.*/PermitEmptyPasswords no/g' /etc/ssh/sshd_config
   sudo chmod 600 /etc/ssh/sshd_config
   sudo systemctl restart sshd
   ```
   Note: At home you'll probably want to use a key instead of a password!!!
   
2. Update and upgrade packages
   ```zsh
   sudo apt update -y
   sudo apt upgrade -y
   sudo apt install curl git wireguard nfs-common ca-certificates open-iscsi ufw
   ```
   
3. Configure UFW
   ```zsh
   sudo ufw allow 6443/tcp # k3s apiserver
   sudo ufw allow from 10.42.0.0/16 to any # k3s pods
   sudo ufw allow from 10.43.0.0/16 to any # k3s services
   sudo ufw allow 22/tcp # SSH
   sudo ufw allow 80/tcp # HTTP
   sudo ufw allow 8080/tcp # Alt HTTP
   sudo ufw allow 443/tcp # HTTPS
   sudo ufw allow 8443/tcp # Alt HTTPS
   sudo ufw enable
   ```
   Note: You'll have to allow the port that NodePort assigns.
   
4. Harden sysctl.conf
   ```zsh
   echo "net.ipv6.conf.all.disable_ipv6 = 1" | sudo tee -a /etc/sysctl.conf
   echo "net.ipv6.conf.default.disable_ipv6 = 1" | sudo tee -a /etc/sysctl.conf
   echo "net.ipv6.conf.all.accept_redirects = 0" | sudo tee -a /etc/sysctl.conf
   echo "net.ipv6.conf.default.accept_redirects = 0" | sudo tee -a /etc/sysctl.conf

   echo "net.ipv4.tcp_syncookies = 1" | sudo tee -a /etc/sysctl.conf
   echo "net.ipv4.conf.all.log_martians = 1" | sudo tee -a /etc/sysctl.conf
   echo "net.ipv4.tcp_rfc1337 = 1" | sudo tee -a /etc/sysctl.conf
   echo "net.ipv4.ip_forward = 1" | sudo tee -a /etc/sysctl.conf

   echo "net.core.bpf_jit_harden = 2" | sudo tee -a /etc/sysctl.conf

   echo "kernel.pid_max = 65536" | sudo tee -a /etc/sysctl.conf
   echo "kernel.randomize_va_space = 2" | sudo tee -a /etc/sysctl.conf
   echo "kernel.yama.ptrace_scope = 1" | sudo tee -a /etc/sysctl.conf
   echo "kernel.perf_event_paranoid = 2" | sudo tee -a /etc/sysctl.conf
   echo "kernel.kptr_restrict = 2" | sudo tee -a /etc/sysctl.conf
   echo "kernel.sysrq = 0" | sudo tee -a /etc/sysctl.conf

   echo "fs.suid_dumpable = 0" | sudo tee -a /etc/sysctl.conf
   echo "fs.protected_hardlinks = 1" | sudo tee -a /etc/sysctl.conf
   echo "fs.protected_symlinks = 1" | sudo tee -a /etc/sysctl.conf

   sudo sysctl -p
   sudo update-initramfs -k all -u
   ```
  
5. Install Docker Engine
   ```zsh
   sudo install -m 0755 -d /etc/apt/keyrings
   sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
   sudo chmod a+r /etc/apt/keyrings/docker.asc

   echo \
     "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
     $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
   sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

   sudo apt-get update
   sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
   sudo usermod -aG docker $USER
   sudo systemctl enable docker.service
   sudo systemctl enable containerd.service
   ```
6. Install k3s

### Docker
The following steps assume you're running Debian/Ubuntu and have Docker installed.

1. Clone the repository:
   ```zsh
   git clone https://github.com/Xata/nautilus-demo-website.git
   ```
2. Move into the correct directory:
   ```zsh
   cd nautilus-demo-website/
   ```

3. Build the container with:
   ```zsh
   docker build . -t xata/nautilus-demo-website
   ```

4. Run the container with:
   ```zsh
   docker run -d -p 80:8080 xata/nautilus-demo-website
   ```

Once you've checked to see that the container is working, stop the container:
1. List the containers running:
   ```zsh
   docker ps 
   ```

2. Stop the container:
   ```zsh
   docker stop YOUR_CONTAINER_NAME-1a-s09da-0s9213941
   ```
   
3. Remove the container (why not?):
   ```zsh
   docker rm YOUR_CONTAINER_NAME-1a-s09da-0s9213941
   ```

### k3s
During the Kubernetes MiniShop, you will have to execute these steps:

1. Import the local image into k3s:
   ```zsh
   docker save xata/nautilus-demo-website | sudo k3s ctr images import -
   ```

2. Check to see if the image was imported to the local registry:
   ```zsh
   sudo crictl images
   ```

3. Apply the service and deployment files:
   ```zsh
   kubectl apply -f deployment.yaml
   kubectl apply -f service.yaml
   ```

4. Check to see what port was assigned to the pod:
   ```
   kubectl get svc
   ```

It should look something like this:
   ```zsh
   NAME                    TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)        AGE
   kubernetes              ClusterIP   10.43.0.1      <none>        443/TCP        28m
   nautilus-demo-website   NodePort    10.43.11.101   <none>        80:31977/TCP   11m
   ```

Note: You may have to allow the port in UFW first:
   ```zsh
   sudo ufw allow 31977/tcp
   sudo ufw reload
   ```

5. Now you can access the webpage at the assigned port:
   ```zsh
   http://192.168.1.234:31977
   ```
   Note: The port and IP will change based on your network!


## Technologies Used

![Nginx](https://img.shields.io/badge/nginx-%23009639.svg?style=for-the-badge&logo=nginx&logoColor=white)
![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)
![HTML5](https://img.shields.io/badge/html5-%23E34F26.svg?style=for-the-badge&logo=html5&logoColor=white)
![Kubernetes](https://img.shields.io/badge/kubernetes-%23326ce5.svg?style=for-the-badge&logo=kubernetes&logoColor=white)
![Git](https://img.shields.io/badge/git-%23F05033.svg?style=for-the-badge&logo=git&logoColor=white)

## Nautilus Image Attribution
The primary image that is displayed can be found here: 
© <a href="/wiki/User:FredD" title="User:FredD">Frédéric Ducarme</a>&nbsp;/&nbsp;<a href="/wiki/Main_Page" title="Main Page">Wikimedia Commons</a>
