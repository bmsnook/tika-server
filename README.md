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

### Extract
`./tika-extract.sh input-filename`  
or  
`./tika-extract.sh -i input-filename`  

I have plans to add an option to specify an output file for the extracted text, but this was not part of the problem specification in the exercise. In the spirit of the Agile approach for "minimum viable product," this in-progress code is not included in the main branch.

### Examples:
**Example 1**
```
% ./tika-extract.sh files/lyrics__let_it_go__french__liberee_delivree.rtf | head           
http://www.paroles.net/la-reine-des-neiges/paroles-liberee-delivree

L'hiver s'installe doucement dans la nuit
La neige est reine à son tour
Un royaume de solitude
Ma place est là pour toujours

Le vent qui hurle en moi ne pense plus à demain
Il est bien trop fort
J'ai lutté, en vain
% 
```
**Example 2**
```
% ./tika-extract.sh files/Lyrics\ -\ Let\ It\ Go\ -\ German\ -\ Lass\ jetzt\ los.pdf | head

http://www.magistrix.de/lyrics/Willemijn%20Verkaik/Lass-Jetzt-Los-Uebersetzung-1184347.html
http://www.magistrix.de/lyrics/Willemijn%20Verkaik/Lass-Jetzt-Los-1181303.html

Lass jetzt los Lyrics
Der Schnee glänzt weiß auf dem Bergen heut Nacht, keine 

Spuren sind zu sehen. 
Ein einsames Königreich, und ich bin die Königin. 

% 
```
