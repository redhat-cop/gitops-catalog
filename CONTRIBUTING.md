# Contributions Guidelines

Contributions are welcome from all, here are quick notes on the structure and things to avoid when contributing.

In general the root folder should represent the functionality being provided with additional folders splitting the functionality as necessary. For example, many operators require that an operator subscription be created followed by an instance. In this case the following structure woule be used:

```
- /<name>-operator
    -- /operator
        - /base
        - /overlays
            - /channelA
            - /channelB
    -- /instance
```

When adding operators please do include `startingCSV` unless there is a compelling reason to do so. The Operator Lifecycle Manager (OLM) will automatically use the latest version when `startingCSV` is not specified, including it places additional maintenance burdens in keeping it up to date.

Overlays for operators should generally use the `channel` name as the name of the overlay if multiple channels are available. For example, if the channel names are `tech-preview` and `stable` then name the overlays the same corresponding to the channels.
