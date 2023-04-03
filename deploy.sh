#Copy-Item -Path ./_site/* -Destination ../github.io -Recurse -Force -Exclude *.ps1,*.cmd

rsync -av --exclude=*.ps1 --exclude=*.sh --exclude=package*.* ./_site/* ../github.io