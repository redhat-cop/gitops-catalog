# SonarQube 8.2 Community

## Configuration

Default username and password: `admin/admin`

The manifests in this repository will setup SonarQube 8.2 Community, however you will have to install whatever plugins that you want to use to make SonarQube actually useful once it is running.

To do this, login to SonarQube as the admin user and go to the Marketplace.  From there, you can search for the plugins you would like to install (e.g. Java, JaCoCo, Dependency Check, etc...).  Once you "install" the plugins, you will need to restart SonarQube for them to take effect (restart button becomes available at the top of the screen after you install at least one plugin).

These plugins will be persisted in the `/opt/sonarqube/extensions` pvc mount.

## Known Issues

This will **not** work out of the box on CodeReady Containers until [this issue](https://github.com/code-ready/crc/issues/1121) is resolved.