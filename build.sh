docker pull php:cli 
docker run -ti -v $PWD/xml.php:/xml.php php:cli php /xml.php > /tmp/versions
IFS=" "
while read version fullVersion url md5
do
    echo "Build: $fullVersion, Tag: $version"
    BUILDKIT_PROGRESS=plain docker build --build-arg="DRUPAL_VERSION=$fullVersion" -t tanarurkerem/drupal:$version .
    docker push tanarurkerem/drupal:$version
    echo "Build: $fullVersion, Tag: $fullVersion"
    BUILDKIT_PROGRESS=plain docker build --build-arg="DRUPAL_VERSION=$fullVersion" -t tanarurkerem/drupal:$fullVersion .
    docker push tanarurkerem/drupal:$fullVersion
    if [ "$version" == "9.0" ]; then
        echo "Build: $fullVersion, Tag: latest"
        BUILDKIT_PROGRESS=plain docker build --build-arg="DRUPAL_VERSION=$fullVersion" -t tanarurkerem/drupal:latest .
        docker push tanarurkerem/drupal:latest
    fi
done < /tmp/versions