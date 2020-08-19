# SonarQube 8.2 Community

## Configuration

Default username and password: `admin/admin`

The manifests in this repository will setup SonarQube 8.2 Community.

## Overlays

### default

The `default` overlay simply includes the base.  This is a persistent SonarQube 8 instance with no added configuration.

### plugins

The `plugins` overlay adds a post deploy hook that installs a list of SonarQube plugins.  It is recommended that you create your own `plugins` overlay if
you want to customize the list of plugins that you want installed by default in SonarQube.
