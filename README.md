# Passionate Test

#### Dependencies
* Redis
* PostgresQL

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
### View api docs
```console
foo@bar:~$ ./generate_api_docs.sh
```
### Questions
##### How does your solution perform?
Reasonably well, there are no obvious performance problems.
I used netflix' `fast_jsonapi` serializer which performs better the `active_model_serializers`, also we get added bonus of complying with jsonapi spec.
In the future i might implement services based on dry libs with use of monads to skip expensive exception catching
It's better to check if there is a problem with performance rather than optimizing prematurely.
#### How does your solution scale?
The code is whiten in modular way, so adding new features is easy. 
Programmer wouldn't waste a ton of time looking through loads of obscure code, so scaling teams is easy.

#### What would you improve next?
Stuff mentioned in the first question.

### Additional optional questions
#### What was one of the biggest coding challenges that you ever had?
Once upon a time here was this one PHP spagetti CRM written in custom framework 100500 years ago. 
It featured a long running job which was zipping a db dump of a particular resource. 
It took 15 mins and it needed to be zipped and serialised in different ways for each of 20 exports.
There was this bug which would cause some of exports to fail sometimes.
Debugging that thing was a nightmare...
Turned out if some combinations of exports are ran together, server would run out of ram and export would be half zipped and marked as compete in CRM.
This in turn would cause disk storage to run out pretty quickly and whole site would die sometimes.
Memory thing was solved by writing stuff in chunks without loading them into memory.
Disk space problem was solved by implementing sort of transaction and pruning failed zips in cron task.
