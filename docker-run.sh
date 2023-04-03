currDir=$(pwd)

docker run --rm -v $currDir:/srv/jekyll -p 4000:4000 -it jekyll/builder:4 bash

# jekyll build
# jekyll serve
# more commands at: https://github.com/MilanAryal/CLI-Cheat-Sheet/blob/master/jekyll-commands.md

# Things needed to install new bundles
# bundle init
# bundle add kramdown-parser-gfm
# bundle add jekyll-watch
# bundle install