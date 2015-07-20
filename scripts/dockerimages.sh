DOCKER_IMAGES="
gliderlabs/registrator:latest
shipyard/rethinkdb
shipyard/shipyard
progrium/consul
registry:2
ansible/ubuntu14.04-ansible:1.8
"
docker pull $DOCKER_IMAGES
