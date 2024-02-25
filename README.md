# 3D Skins Online

**3D Skins Online** is an [Openplanet](https://openplanet.dev) plugin that makes other people see your custom 3d model skins online!

## Overview

This plugin works by making the server use the unoptimized download URL for the skin you are using. Typically, when you upload a skin, it undergoes optimization, resulting in the generation of a different URL. The game, by default, uses this optimized URL. However, 3D Skins Online forces the game to utilize the original download URL, ensuring that others can experience your custom skins as intended.

## Important Note

Please be aware that this plugin is currently unsigned and does not appear in Openplanet's plugin manager. There's a possibility it may never be officially included unless a better solution is found. To use this plugin, follow these manual steps:

1. Download the plugin **3DSkinsOnline.op** from the [releases](https://github.com/AurisTFG/tm-3d-skins-online/releases/latest) tab on GitHub.
2. Place the downloaded plugin in your `"C:\Users\auris\OpenplanetNext\Plugins"` folder.
3. Enable Developer Mode in Openplanet by navigating to `Developer -> Signature Mode -> Developer`.
4. That's it! The plugin should be able to handle everything on it's own from now on.

Feel free to reach out if you have any questions or encounter issues. Happy trolling!

## Important Note 2

As of the beginning of 2024, it appears that all types of skins, both 2D and 3D, do not contain an optimized URL in the API. Therefore, they just work without the need for any plugins. If you wish to use a 3D skin from 2023 online, simply re-upload the skin while also making a minor modification in the skin .zip file to ensure its recognition as new (e.g. adding a random .txt file). Do not forget that certain limitations, such as dimension and vertex count constraints, still remain relevant. Although a plugin to break these limits on the client side would be kinda fun, it may or may not be done at some point in the future.
