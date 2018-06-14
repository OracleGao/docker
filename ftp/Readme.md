## Ref
- https://github.com/stilliard/docker-pure-ftpd

## add users
- exec the under cmd with username cpic in the container
```shell
pure-pw useradd cpic -f /etc/pure-ftpd/passwd/pureftpd.passwd -m -u ftpuser -d /home/ftpusers/cpic
```
