# Tika-Server
## Background
This project was written to install an instance of Apache Tika as an exercise.

https://tika.apache.org/

I've kept copies of the signature files to verify the package in the main level of this repo, but moved the downloaded jar file and a simple script to start it into a subdirectory "tika" to be copied directly into the Docker container.

I've copied the keys for my own convenience. You probably want to download a copy of the jar and verify it for yourself.

The keys for verification can be downloaded from Apache:

https://people.apache.org/keys/group/tika.asc

and the signatures for downloadable packages are available on the download page at 

https://tika.apache.org/download.html

## Usage
### Download
`git clone https://github.com/bmsnook/tika-server.git`  

### Build
`docker build -t tika-server .`  

### Run
`docker run --rm -d -p 9998:9998 --name tika-server tika-server`  

### Verify
`curl -X GET http://localhost:9998/tika`  

**Output should look like**  
`This is Tika Server (Apache Tika 1.18). Please PUT`  


