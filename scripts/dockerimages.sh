DOCKER_IMAGES="
gliderlabs/registrator:latest
shipyard/rethinkdb
shipyard/shipyard
progrium/consul
registry:2
"
docker pull $DOCKER_IMAGES
