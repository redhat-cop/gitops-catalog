A deployment that uses minimal resources, great for smaller clusters where you are just doing demos.

There is an aggregate overlay for use with Argo CD that uses sync waves to push things out in order. For the sync wave to work you will need to add a health check for Central in the resources section of your configuration:

```
platform.stackrox.io/Central:
    health.lua: |
    hs = {}
    if obj.status ~= nil and obj.status.conditions ~= nil then
        for i, condition in ipairs(obj.status.conditions) do
            if condition.status == "True" and condition.reason == "InstallSuccessful" then
                hs.status = "Healthy"
                hs.message = condition.message
                return hs
            end
        end
    end
    hs.status = "Progressing"
    hs.message = "Waiting for Central to deploy."
    return hs
```