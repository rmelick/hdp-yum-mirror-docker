# hdp-yum-mirror-docker
A docker image that runs a yum mirror of the repos necessary for HDP

Deploy the image with a command like the following
```
docker run --name local-hdp-mirror -d -e FQDN=hdpmirror.example.com -v /tmp/hdpmirrors:/usr/local/apache2/htdocs/mirrors rmelick/hdp-yum-mirror-docker:latest
```
This will store all the downloaded mirrors files into /tmp/hdpmirrors so that they are easily accessible after restarting
the yum container

After deploying the image, add the repository to your local yums by using
```
yum-config-manager --add-repo http://hdpmirror.example.com/hdp-clones.repo
```

You can check that the mirror has been added correctly by running
```
yum repolist
```