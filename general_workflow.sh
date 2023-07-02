#common practices
git remote rename origin upstream
git remote add origin git@github.com:iSystemske/account-api
git push -u origin main


WARNING: Image for service app was built because it did not already exist. To rebuild this image you must use `docker-compose build` or `docker-compose up --build`.
Creating som-mot_app_1 ... done
Attaching to som-mot_app_1
KUBERNETES | DOCKER
docker ps -a [list all containers]
--stop all---
docker stop $(docker ps -a -q)
--login to container--
docker exec -it 5e081e5b28dc bash

--images---
docker image ls --all
docker volume prune

--alias--
updaterecords
projects
sis



sudo chown -R root upper-p.elmischools.com
sudo chgrp -R www-data upper-p.elmischools.com
sudo chmod -R 775 upper-p.elmischools.com
sudo chmod g+s upper-p.elmischools.com
sudo chmod u+w uploads



C:\users\kelvin\AppData\Local\Android\Sdk\emulator

.\emulator.exe -avd Pixel_3a_API_33_x86_64
