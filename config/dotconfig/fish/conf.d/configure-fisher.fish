set -g fisher_path $HOME/.fisher-packages
set fish_function_path $fish_function_path[1] $fisher_path/functions $fish_function_path[2..-1]
set fish_complete_path $fish_complete_path[1] $fisher_path/completions $fish_complete_path[2..-1]
for file in $fisher_path/conf.d/*.fish
    builtin source $file 2> /dev/null
end

if not functions -q fisher
    echo "Install fisher with `curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher`"
end
