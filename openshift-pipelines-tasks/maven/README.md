### Introduction

This is a tekton maven task with some enhancements over the default cluster task including:

- Uses a supported Red Hat image for maven instead of a maven image from the Google Container Registry
- Includes an overlay to cache the M2 Repository in a PV for improved build times at the cost of storage

### M2 Repository Caching

If you want to cache your M2 repository you can use the overlays/m2-cache version of the task. In order to use this version,
you must provide a PVC with the name `m2-cache` as it will get mounted into the pod.

Note that if you change the default image you will likely need to change the parameter `M2_DIRECTORY` in the task to point
to where the m2 repository is located. This is because the M2 location is typically tied to the home directory and different
images will specify different users and thus different home directories.
