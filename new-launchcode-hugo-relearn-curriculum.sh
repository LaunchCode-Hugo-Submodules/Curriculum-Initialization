#!/bin/bash
project_name=$1
project_directory=$2
original_directory=$(pwd)

if [[ $project_directory != "" ]]
then
	mkdir -p $project_directory
	cd $project_directory
else
	cd ..
fi

hugo new site $project_name

cd $project_name

git init

git submodule add https://github.com/LaunchCode-Hugo-Submodules/vs-code-snippets.git .vscode

git submodule add https://github.com/LaunchCode-Hugo-Submodules/hugo-theme-relearn themes/hugo-theme-relearn

touch hugo.toml

echo 'theme = "hugo-theme-relearn"' >> hugo.toml

rm -rf layouts

git submodule add https://github.com/LaunchCode-Hugo-Submodules/layouts

rm -rf static

git submodule add https://github.com/LaunchCode-Hugo-Submodules/static

rm -rf archetypes

git submodule add https://github.com/LaunchCode-Hugo-Submodules/archetypes

echo -e '\n[outputs]' >> hugo.toml

echo -e '  home = ["HTML", "RSS", "SEARCH"]' >> hugo.toml

echo -e '\n[params]' >> hugo.toml

echo -e '  themeVariant = ["lc-light", "lc-dark-blue", "lc-dark-blue-two"]' >> hugo.toml

(
cat <<'EOF'
+++
chapter = false
title = "Home"
description = "LaunchCode Technical Training"
date = 2021-10-01T09:28:27-05:00
draft = false
+++

# LaunchCode

You just created a brand new curriculum! Feel free to create new chapters or segments however you normally would. You can also find useful links below that may help inspire.

You pulled in three LaunchCode created github submodules:
- `layouts`: provides slides shortcode and overwrites menu footer
- `static`: provides launchcode logo, favicon, and theme variants
- `archetypes`: provides segment archetype for new chapters

Example usage of segment:
```bash
hugo new --kind chapter <name>/_index.md
```

Upon running the above command it will create a new chapter named `chapter-name`

## Helpful Links

[LaunchCode Education Github](https://github.com/LaunchCodeEducation)

[Relearn Documentation](https://mcshelby.github.io/hugo-theme-relearn/)

EOF
) > content/_index.md

cd $original_directory
