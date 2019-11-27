# Passionate Test

### Deploy
* Copy database.yml
```console
foo@bar:~$ cp config/database.yml.sample config/database.yml
```
* Install foreman
```console
foo@bar:~$ gem install foreman
```
* Adjust to your local setup in database.yml
* Run the app
```console
foo@bar:~$ foreman start -f Procfile.dev
```
