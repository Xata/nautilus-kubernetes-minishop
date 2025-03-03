# nautilus-demo-website
Hello and welcome to the nautilus-demo-website repository! The goal of this project is to provide a simple (and I mean SIMPLE) website for students to check to see if their infrastructure is working.
This is a simple static webpage that displays an image of a nautilus. 

![GitHub commit activity](https://img.shields.io/github/commit-activity/t/Xata/nautilus-demo-website?style=for-the-badge)
![GitHub top language](https://img.shields.io/github/languages/top/Xata/nautilus-demo-website?style=for-the-badge)
![GitHub repo size](https://img.shields.io/github/repo-size/Xata/nautilus-demo-website?style=for-the-badge)

## About this project

This is a simple static webpage that displays a nautilus upon visiting the site. This is used to check to make sure if your infrastructure has been setup and is working correctly. 

## Usage

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
