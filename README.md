# hdp-yum-mirror-docker
A docker image that runs a yum mirror of the repos necessary for HDP

Deploy the image with a command like the following
```
docker run --name local-hdp-mirror -d -e FQDN=hdpmirror.example.com rmelick/hdp-yum-mirror-docker:latest
```

After deploying the image, add the repository to your local yums by using
```
yum-config-manager --add-repo http://hdpmirror.example.com/hdp-clones.repo
```

You can check that the mirror has been added correctly by running
```
yum repolist
```