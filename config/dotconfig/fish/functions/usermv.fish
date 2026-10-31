function usermv --description 'sudo mv files, then chown them to the user whose home they land in'
    argparse -n usermv 'h/help' 'u/user=' 'n/dry-run' 'f/force' -- $argv
    or return 2

    if set -q _flag_help; or test (count $argv) -lt 2
        echo "Usage: usermv [-u USER] [-n] [-f] SOURCE... DEST" >&2
        echo "  Moves SOURCE(s) to DEST with sudo, then chowns them to USER." >&2
        echo "  USER defaults to the owner of the home directory DEST is under" >&2
        echo "  (/Users/NAME or /home/NAME)." >&2
        echo "  Refuses to overwrite anything that already exists unless -f is given." >&2
        test -n "$_flag_help"; and return 0; or return 2
    end

    set -l dest $argv[-1]
    set -l sources $argv[1..-2]

    set -l user $_flag_user
    if test -z "$user"
        set user (string match -r '^/(?:Users|home)/([^/]+)' -- $dest)[2]
        or begin
            echo "usermv: cannot infer user from '$dest'; pass -u USER" >&2
            return 2
        end
    end
    if not id -u -- $user >/dev/null 2>&1
        echo "usermv: no such user '$user'" >&2
        return 2
    end

    set -l run sudo
    set -l test_cmd sudo test
    if set -q _flag_dry_run
        set run echo sudo
        set test_cmd test
    end

    # Work out where each source will end up, so the chown hits exactly those paths
    # and nothing else. Other users' home subdirectories are usually mode 700, so
    # the directory check has to go through sudo.
    set -l targets
    if $test_cmd -d $dest
        set -l dir (string trim -r -c / -- $dest)
        test -z "$dir"; and set dir /
        for src in $sources
            set -l base (path basename -- $src)
            if contains -- $base . .. /
                echo "usermv: refusing to move '$src' (no usable basename)" >&2
                return 2
            end
            set -a targets $dir/$base
        end
    else if test (count $sources) -gt 1
        echo "usermv: moving multiple sources requires DEST to be an existing directory" >&2
        return 2
    else
        set targets $dest
    end

    # mv overwrites silently (and as root, nothing stops it). Check first, and
    # check every target before moving anything.
    if not set -q _flag_force
        set -l clobber
        for t in $targets
            if $test_cmd -e $t; or $test_cmd -L $t
                set -a clobber $t
            end
        end
        if test (count $clobber) -gt 0
            echo "usermv: refusing to overwrite existing path(s), use -f to force:" >&2
            printf '  %s\n' $clobber >&2
            return 1
        end
    end

    $run mv -- $sources $dest
    and $run chown -R -h -- "$user:" $targets
end
