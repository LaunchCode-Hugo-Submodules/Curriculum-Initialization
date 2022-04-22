## User can also provide an absolute path as an argument

## How to load an argument? - Name of project

project_name=$1
original_directory=$(pwd)

cd ..

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

cd $original_directory
