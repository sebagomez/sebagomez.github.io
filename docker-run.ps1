$currDir = (Get-Location).Path -replace '\\','/'

docker run --rm -v ${currDir}:/srv/jekyll -p 4000:4000 -it jekyll/builder:3 bash

# jekyll build
# jekyll serve
# more commands at: https://github.com/MilanAryal/CLI-Cheat-Sheet/blob/master/jekyll-commands.md