docker run -d --rm --name pg17_one -e POSTGRES_PASSWORD=secret123 \
  -v /home/vg/purpleschool/ps-dz6.9/pgdata_one:/var/lib/postgresql/data \
  postgres:17-alpine

docker rm -f pg17_one

sudo mv pgdata_one/ pgdata_two

docker run -d --rm --name pg17_two -e POSTGRES_PASSWORD=secret123 \
  -v /home/vg/purpleschool/ps-dz6.9/pgdata_two:/var/lib/postgresql/data \
  postgres:17-alpine
