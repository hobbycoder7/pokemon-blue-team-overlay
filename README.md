# Pokemon Blue Team Overlay/Widget/Tracker

The goal is to allow your viewers to see your Pokemon Blue team without you having to manually update anything or show them through the in-game interface.

How it works is as you play the game your Pokemon team is saved to an htm file with their names and levels. Whenever your team changes, the htm file is updated. You view the htm file in a web browser which allows you to capture and add the team to your stream overlay. The program [Livereload](http://livereload.com/) monitors the htm file for changes and refreshes the webpage so that your viewers will see team updates as they happen live. It's all done automatically. You just need to play the game and have fun!

---

__CURRENTLY ONLY 6 POKEMON IMAGES ARE SUPPLIED.__

__TO ADD THE REST:__
* Download/save images to _assets/img/pokemon/_ folder
* * Current sprites are from [Pokémon Database](https://pokemondb.net/sprites/)
* Name image AFTER Pokemon ID. 
* * ID's are "dec" from [http://bulbapedia.bulbagarden.net](http://bulbapedia.bulbagarden.net/wiki/List_of_Pok%C3%A9mon_by_index_number_(Generation_I))
* * Example: Rhydon would be saved as 1.gif, Electabuzz would be 53.gif, etc.
---

## Install
* Download [vba-rr / VBA-ReRecording](http://tasvideos.org/EmulatorResources/VBA.html)
* Download [Livereload](http://livereload.com/)
* Open Livereload
* Open pokemon.htm in web browser
* Load Pokemon Blue rom
* In vba-rr goto Tools > Lua Scripting > New Lua Scripting Window... 
* In the new window click Browse... and select the pokemon.lua file. 
* Click the Run button and play!

---

### Resources:
* Sprites: https://pokemondb.net/sprites/ (only 6 currently downloaded)
* Background image: http://grumble-bum.deviantart.com/art/Pokeball-Wallpaper-296428004
* Font: http://www.fontspace.com/jackster-productions/pokemon-gb
* https://www.pokecommunity.com/showthread.php?p=6737744
* http://bulbapedia.bulbagarden.net/wiki/List_of_Pok%C3%A9mon_by_index_number_(Generation_I)
* https://www.youtube.com/watch?v=UKPKguaNYtI
* http://datacrystal.romhacking.net/wiki/Pok%C3%A9mon_Red/Blue:RAM_map#Player
* http://datacrystal.romhacking.net/wiki/Pok%C3%A9mon_Red_and_Blue:TBL
* http://tasvideos.org/EmulatorResources/VBA/LuaScriptingFunctions.html
