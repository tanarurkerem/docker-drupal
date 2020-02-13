# docker-drupal
Woluld you like to try Drupal 9? Use this two simple command for it:

```
  docker run --name drupal -d --rm -p 80:80 tanarurkerem/drupal
  docker exec -it -u www-data drupal php core/scripts/drupal install demo_umami
```
