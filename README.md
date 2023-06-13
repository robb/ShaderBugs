![](img/screenshot.png)

Issues found so far (see [here](ShaderBugs/ContentView.swift)):

- Passing in an additional texture fails silently (distortion effect) or breaks the ability to sample the layer (layer effect).

- After a certain number (or size?) of arguments, shaders fail silently.

API limitations:

- I found no way to turn a dynamically compiled `MTLLibrary` into a `ShaderLibrary`. There is `ShaderLibrary(data:)` but it's unclear to me where this data would come from, other than disk.

- Run-time errors or at least console logs for argument mismatch would be highly appreciated.

- I found no way to sample what's behind the view to build e.g. custom a `Material`-like effect. There's ways to work around the limitation by installing the effect on the nearst common ancestor but that seems inefficient?
