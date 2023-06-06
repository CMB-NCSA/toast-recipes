export CMBS4USER=cmbs4user
export IMAGE=menanteau/toast_ubuntu
export TOAST_VERSION=0f8e6b5
export TAG=${TOAST_VERSION}_v2
docker build -f docker/Dockerfile -t $IMAGE:$TAG --build-arg CMBS4USER --build-arg TOAST_VERSION --rm=true .

echo 'Push commands:'
echo "   docker push $IMAGE:${TAG}"

echo 'To create singularity image:'
echo "  ./docker2singularity $IMAGE:${TAG}"
