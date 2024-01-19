# Issue:
when running a simple Maven build step with container wrapper where the user is different (see Dockerfile)
The build fails since the user under which container runs is not the TeamCity agent user and does not have permissions to buildAgent dir and mounted files


For docker it seems to be non-important but podman cannot run such builds

# I tried the following:

## ON THE HOST:
* sudo groupadd sharedgroup
* sudo usermod -a -G sharedgroup ec2-user
* sudo chown -R :sharedgroup buildAgent
* sudo chmod -R g+s buildAgent
* sudo chmod -R g+rw buildAgent

to get the group id:
`getent group sharedgroup`

## in dockerfile

* `RUN groupadd -g 1001 sharedgroup && \
useradd -ms /bin/bash -g sharedgroup newuser`
* `USER newuser`

So we run under newuser which is in the sharedgroup and should have permissions, but this didnt work for some reason...

Even if I enable rootful podman (teamcity.docker.use.sudo=true agent property) - still permission denied, BUT! it sees the proper "sharedgroup" when inside the container, without it it sees it as "nobody"