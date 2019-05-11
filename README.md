FoOlSlide
=========

FoOlSlide is a ridiculously ~~elaborated~~ unmaintainable comic reader meant for users to enjoy reading

Installation
------------
1.  Copy everything in the archive in a public server folder
2.  Create a database (MySQL, MSSQL, MySQLi, SQLite...)
3.  Go to http://yourdomain.com/slidefolder/install
4.  Insert database info and admin account info
5.  Done

Notes
-----------
This fork moves config.php to config/config.php so the folder can be mounted with docker

Docker Setup
------------
* Create a folder on the server for persistant files (will be reffered to as `<persistant>`)
* Copy the `config` (config file) and `content` (uploaded images, logs) folders into `<persistant>`
* Create an `apache_logs` folder for apache logs and an `sql_db` folder (if using mysql in docker) in `<persistant>`
* Run `docker build -t foolslide .` to build the docker image
* If using sql in docker run
```bash
docker run -d --name foolslide-mysql -e MYSQL_ROOT_PASSWORD=<sql_root_passward> -e MYSQL_USER=<sql_user> -e MYSQL_PASSWORD=<sql_password> -e MYSQL_DATABASE=<sql_database> -v '<persistant>/sql_db:/var/lib/mysql' mysql:8.0.3
```
* Run
```bash
docker run -d -p <port>:80 -v "<persistant>/apache_logs:/var/log/apache2" -v "<persistant>/content:/var/www/html/content" -v "<persistant>/config:/var/www/html/config" --link foolslide-mysql:sql --name foolslide foolslide
```
If not running mysql in docker, remove `--link foolslide-mysql:sql` (You may need `--network="host"` or something, I don't know). If you are, use `sql` as the hostname for the db
* Go to step 3 of a normal install

### Notes

To stop the containers run `docker kill foolslide` and `docker kill foolslide-mysql`

In a dev environment you will likely want to replace `-d` with `--rm` and mount (`-v`) the entire repo to `/var/www/html`
