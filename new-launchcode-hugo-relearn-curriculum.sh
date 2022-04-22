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

git submodule add https://github.com/LaunchCode-Hugo-Submodules/hugo-theme-relearn themes/hugo-theme-relearn

echo 'theme = "hugo-theme-relearn"' >> config.toml

rm -rf layouts

git submodule add https://github.com/LaunchCode-Hugo-Submodules/layouts

rm -rf static

git submodule add https://github.com/LaunchCode-Hugo-Submodules/static

rm -rf archetypes

git submodule add https://github.com/LaunchCode-Hugo-Submodules/archetypes

echo -e '\n[params]' >> config.toml

echo -e '  themeVariant = ["lc-light", "lc-dark-blue", "lc-dark-blue-two"]' >> config.toml

(
cat <<'EOF'
---
title: "Home"
date: 2021-10-01T09:28:27-05:00
draft: false
---

# LaunchCode

You just created a brand new curriculum! Feel free to create new chapters or segments however you normally would. You can also find useful links below that may help inspire.

You pulled in three LaunchCode created github submodules:
- `layouts`: provides slides shortcode and overwrites menu footer
- `static`: provides launchcode logo, favicon, and theme variants
- `archetypes`: provides segment archetype for new chapters

Example usage of segment:
```bash
hugo new --kind segment chapter-name
```

Upon running the above command it will create a new chapter named `chapter-name`

{{% notice warning %}}
Replace the content of this entire file with the desired homepage contents of this course!
{{% /notice %}}

## Helpful Links

[LaunchCode Technical Training Github](https://github.com/LaunchCodeTechnicalTraining)

[Relearn Documentation](https://mcshelby.github.io/hugo-theme-relearn/)

[Live link to Linux Curriculum](https://lctt-linux.netlify.app/)
EOF
) > content/_index.md

hugo new --kind segment example-chapter

cd $original_directory
