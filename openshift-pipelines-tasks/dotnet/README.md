# Dotnet CLI Task

Current .Net Core versions supported:
* 5.0

Sample task usage:

```
    - name: build-app
      taskRef:
        name: dotnet-cli
        kind: Task
      runAfter:
        - clone-source
      workspaces:
        - name: source
          workspace: shared-workspace
      params:
        - name: COMMANDS
          value: ["publish","-c","Release","--source","http://nexus.cicd-tools.svc.cluster.local:8081/service/local/nuget/nuget-gallery"]
```

**Note:** the `--source` parameter in the example is just one way to use your own artifact repository for NuGet, provided it has been properly configured as a NuGet proxy.

The [Nexus 2](https://github.com/redhat-cop/gitops-catalog/tree/master/nexus2/base) instance is configured by default (through a Job that runs after Nexus is running) as a NuGet proxy.