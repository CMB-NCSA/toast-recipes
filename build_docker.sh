export CMBS4USER=cmbs4user
export IMAGE=menanteau/toast_ubuntu
export TOAST_VERSION=0f8e6b5
docker build -f docker/Dockerfile -t $IMAGE:$TOAST_VERSION --build-arg CMBS4USER --build-arg TOAST_VERSION --rm=true .

echo 'Push commands:'
echo "   docker push $IMAGE:${TOAST_VERSION}"

echo 'To create singularity image:'
echo "  ./docker2singularity $IMAGE:${TOAST_VERSION}"
