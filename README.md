# docker-drupal

This version of image is for only development purpose

Woluld you like to try Drupal 9? Use this one simple command for it:

```
  docker run --name drupal -d --rm -p 80:80 tanarurkerem/drupal
```

If you would like to login into a site run the following command for one time login link:

```
  docker exec -it drupal drush uli
```
