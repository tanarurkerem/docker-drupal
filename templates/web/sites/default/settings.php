<?php
$settings['config_sync_directory'] = '/drupal/config';
$settings['hash_salt'] = getenv('DRUPAL_HASH_SALT', true) ?: 'DEV_SALT_NOT_SAFE';
$settings['deployment_identifier'] = getenv('DRUPAL_DEPLOYMENT_IDENTIFIER', true) ?: \Drupal::VERSION;
$settings['update_free_access'] = getenv('DRUPAL_UPDATE_FREE_ACCESS', true) ?: FALSE;
$settings['file_private_path'] = '/drupal/files';
$settings['container_yamls'][] = $app_root . '/' . $site_path . '/services.yml';
$settings['file_scan_ignore_directories'] = [
    'node_modules',
    'bower_components',
  ];
$settings['entity_update_batch_size'] = 50;
$databases['default']['default'] = array (
    'database' => getenv('DRUPAL_DB', true) ?: 'sites/default/files/.ht.sqlite',
    'username' => getenv('DRUPAL_DB_USERNAME', true) ?: '',
    'password' => getenv('DRUPAL_DB_PASSWORD', true) ?: '',
    'host' => getenv('DRUPAL_DB_HOST', true) ?: '',
    'port' => getenv('DRUPAL_DB_PORT', true) ?: '',
    'driver' => getenv('DRUPAL_DB_DRIVER', true) ?: 'sqlite',
    'prefix' => getenv('DRUPAL_PREFIX', true) ?: '',
);
$config['system.logging']['error_level'] = 'verbose';
$settings['container_yamls'][] = DRUPAL_ROOT . '/sites/development.services.yml';
// opcache-t ki kell kapcsolni!!
$settings['cache']['bins']['render'] = 'cache.backend.null';
$settings['cache']['bins']['dynamic_page_cache'] = 'cache.backend.null';
$settings['cache']['bins']['page'] = 'cache.backend.null';
foreach (['bootstrap','config','data','default','discovery','discovery_migration','dynamic_page_cache','entity','jsonapi_memory','jsonapi_normalizations','jsonapi_resource_types','menu','migrate','page','render','rest','static','toolbar'] as $bin) {
  $settings['cache']['bins'][$bin] = 'cache.backend.null';
}