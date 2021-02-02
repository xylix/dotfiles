# Defined in /var/folders/xz/6y6sty192sbg2m3bb623z6hw0000gn/T//fish.mJjj7J/gh-create-repo.fish @ line 2
function gh-create-repo
    curl --user "$GITHUB_USERNAME:$GITHUB_PASSWORD" --data '{"name:" $argv[1], "description":"Created via API","public":"true","files":{"file1.txt":{"content":"Demo"}}' https://api.github.com/user/repos
end
