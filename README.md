# ps-dz6.9
Purpleschool DZ 6.9

```
vg @ubu24srv: ~/purpleschool/ps-dz6.9 git(dz)  
$ docker pull postgres:17-alpine

$ mkdir /home/vg/purpleschool/ps-dz6.9/pgdata_one

// запуск первого контейнера:
$ docker run -d --rm --name pg17_one -e POSTGRES_PASSWORD=secret123 \
  -v /home/vg/purpleschool/ps-dz6.9/pgdata_one:/var/lib/postgresql/data \
  postgres:17-alpine
adc100224ffe676219dd721f141a5db13c5703705c68dff0bca8e5d28edcaaef

// папка вольюма и его потроха:
vg @ubu24srv: ~/purpleschool/ps-dz6.9 git(dz)  
$ ls -la  
total 20  
drwxrwxr-x  4 vg vg 4096 Aug 27 18:37 .  
drwxrwxr-x 15 vg vg 4096 Aug 27 18:06 ..  
drwxrwxr-x  8 vg vg 4096 Aug 27 18:06 .git  
drwx------ 19 70 vg 4096 Aug 27 18:46 pgdata_one  <--- 70 ???
-rw-rw-r--  1 vg vg   31 Aug 27 18:06 README.md

$ sudo ls -Fm pgdata_one/  
base/, global/, pg_commit_ts/, pg_dynshmem/, pg_hba.conf, pg_ident.conf, pg_logical/, pg_multixact/, pg_notify/, pg_replslot/, pg_serial/, pg_snapshots/, pg_stat/,  
pg_stat_tmp/, pg_subtrans/, pg_tblspc/, pg_twophase/, PG_VERSION, pg_wal/, pg_xact/, postgresql.auto.conf, postgresql.conf, postmaster.opts, postmaster.pid

$ docker exec -it pg17_one psql -U postgres  
psql (17.6)  
Type "help" for help.  

// проверка

postgres=# select version();  
                                        version                                            
-----------------------------------------------------------------------------------------  
PostgreSQL 17.6 on x86_64-pc-linux-musl, compiled by gcc (Alpine 14.2.0) 14.2.0, 64-bit  
(1 row)

// в 1м контейнере создаю табличку и пишу строку:

postgres=# CREATE TABLE mumu(id bigint, name varchar(50));  
CREATE TABLE
postgres=# INSERT INTO mumu(id, name) VALUES (1, 'from container pg17_one');  
INSERT 0 1
postgres=# COMMIT;
WARNING:  there is no transaction in progress   <-- включен автокоммит
COMMIT
postgres=# SELECT * FROM mumu;  
 id |          name              
----+-------------------------  
  1 | from container pg17_one  
(1 row)

postgres=# \q

// удаляю 1й контейнер

$ d rm -f pg17_one  
pg17_one

$ dcols4 -a  
CONTAINER ID   NAMES     IMAGE     STATUS

// переношу папку с данными постгреса:

$ sudo mv pgdata_one/ pgdata_two  
[sudo] password for vg:    
  
vg @ubu24srv: ~/purpleschool/ps-dz6.9 git(dz)  
$ ls -la  
total 20  
drwxrwxr-x  4 vg vg 4096 Aug 27 19:11 .  
drwxrwxr-x 15 vg vg 4096 Aug 27 18:06 ..  
drwxrwxr-x  8 vg vg 4096 Aug 27 18:06 .git  
drwx------ 19 70 vg 4096 Aug 27 18:46 pgdata_two   <---
-rw-rw-r--  1 vg vg   31 Aug 27 18:06 README.md

// запускаю 2й контейнер:

$ docker run -d --rm --name pg17_two -e POSTGRES_PASSWORD=secret123 \
  -v /home/vg/purpleschool/ps-dz6.9/pgdata_two:/var/lib/postgresql/data \
  postgres:17-alpine
55395bce21ba43b960cef6316932cd4a7502d7874fb77e5de01ecb301604d62d

// проверяю данные:

$ docker exec -it pg17_two psql -U postgres  
psql (17.6)  
Type "help" for help.  
  
postgres=# SELECT * FROM mumu;  
 id |          name              
----+-------------------------  
  1 | from container pg17_one     <--- они самые !
(1 row)

postgres=# \q
```
