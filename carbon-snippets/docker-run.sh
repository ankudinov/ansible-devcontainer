docker run --rm -it \
    --network host \
    --pid="host" \
    -w $(CURRENT_DIR) \
    -v $(CURRENT_DIR):$(CURRENT_DIR) \
    -e AVD_GIT_USER="$(shell git config --get user.name)" \
    -e AVD_GIT_EMAIL="$(shell git config --get user.email)" \
    $(AVD_CONTAINER_IMAGE) || true
