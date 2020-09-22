```
docker build -t test-postgres --build-arg SF_ACCOUNT=[REDACTED] --build-arg SF_UNAME=[REDACTED] --build-arg SF_PWD=[REDACTED] .
```

```
docker run --name test-postgres -e POSTGRES_PASSWORD=mysecretpassword -d test-postgres
```

```
docker exec -it test-postgres psql -U postgres
```
