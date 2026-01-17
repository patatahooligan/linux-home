# This is a modified version of the "scales" prompt. The original prompt
# only shows if there exist any type of changes, but not the count. For
# example, if two files have changed, scales would show only "✱". With
# our version we get "✱2".
#
# This should be doable with `fish_git_prompt`, but it will take some
# effort to figure out how to set that up to be as pretty as what I have
# now. Use our custom implementation for now and experiment with
# migrating whenever.

function count_occurences -a expr str
    string match -ar "$expr" "$str" | count
end

function custom_git_prompt
    if not command -sq git
        set_color normal
        return
    end

    # Get the git directory for later use.
    # Return if not inside a Git repository work tree.
    if not set -l git_dir (command git rev-parse --git-dir 2>/dev/null)
        set_color normal
        return
    end

    set_color normal
    echo -n ' ('

    # Get the current action ("merge", "rebase", etc.)
    # and if there's one get the current commit hash too.
    set -l commit ''
    if set -l action (fish_print_git_action "$git_dir")
        set commit (command git rev-parse HEAD 2> /dev/null | string sub -l 7)
    end

    # Get either the branch name or a branch descriptor.
    set -l branch_detached 0
    if not set -l branch (command git symbolic-ref --short HEAD 2>/dev/null)
        set branch_detached 1
        set branch (command git describe --contains --all HEAD 2>/dev/null)
    end

    # Get the commit difference counts between local and remote.
    command git rev-list --count --left-right 'HEAD...@{upstream}' 2>/dev/null \
        | read -d \t -l count_ahead count_behind
    if test $status -ne 0
        set count_ahead 0
        set count_behind 0
    end

    # Get the stash status.
    # (git stash list) is very slow. => Avoid using it.
    set -l status_stashed 0
    if test -f "$git_dir/refs/stash"
        set status_stashed 1
    else if test -r "$git_dir/commondir"
        read -l commondir <"$git_dir/commondir"
        if test -f "$commondir/refs/stash"
            set status_stashed 1
        end
    end

    # git-status' porcelain v1 format starts with 2 letters on each line:
    #   The first letter (X) denotes the index state.
    #   The second letter (Y) denotes the working directory state.
    #
    # The following table presents the possible combinations:
    # * The underscore character denotes whitespace.
    # * The cell values stand for the following file states:
    #   a: added
    #   d: deleted
    #   m: modified
    #   r: renamed
    #   u: unmerged
    #   t: untracked
    # * Cells with more than one letter signify that both states
    #   are simultaneously the case. This is possible since the git index
    #   and working directory operate independently of each other.
    # * Cells which are empty are unhandled by this code.
    # * T (= type change) is undocumented.
    #   See Git v1.7.8.2 release notes for more information.
    #
    #   \ Y→
    #  X \
        #  ↓  | A  | C  | D  | M  | R  | T  | U  | X  | B  | ?  | _
    # ----+----+----+----+----+----+----+----+----+----+----+----
    #  A  | u  |    | ad | am | r  | am | u  |    |    |    | a
    #  C  |    |    | ad | am | r  | am | u  |    |    |    | a
    #  D  |    |    | u  | am | r  | am | u  |    |    |    | a
    #  M  |    |    | ad | am | r  | am | u  |    |    |    | a
    #  R  | r  | r  | rd | rm | r  | rm | ur | r  | r  | r  | r
    #  T  |    |    | ad | am | r  | am | u  |    |    |    | a
    #  U  | u  | u  | u  | um | ur | um | u  | u  | u  | u  | u
    #  X  |    |    |    | m  | r  | m  | u  |    |    |    |
    #  B  |    |    |    | m  | r  | m  | u  |    |    |    |
    #  ?  |    |    |    | m  | r  | m  | u  |    |    | t  |
    #  _  |    |    | d  | m  | r  | m  | u  |    |    |    |
    set -l porcelain_status (
    command git status --porcelain --ignored 2>/dev/null \
        | string sub -l2 \
        | string collect
    )

    set -l count_added (count_occurences '[ACDMT][ MT]|[ACMT]D' $porcelain_status)
    set -l count_deleted (count_occurences '[ ACMRT]D' $porcelain_status)
    set -l count_modified (count_occurences '[MT]\n' $porcelain_status)
    set -l count_renamed (count_occurences 'R' $porcelain_status)
    set -l count_unmerged (count_occurences 'AA|DD|U' $porcelain_status)
    set -l count_untracked (count_occurences '\?\?' $porcelain_status)
    set -l count_ignored (count_occurences '!!' $porcelain_status)

    set_color -o

    if test -n "$branch"
        if test $branch_detached -ne 0
            set_color brmagenta
        else
            set_color green
        end
        echo -n "$branch"
    end
    if test -n "$commit"
        echo -n ' '(set_color yellow)"$commit"
    end
    if test -n "$action"
        set_color normal
        echo -n (set_color white)':'(set_color -o brred)"$action"
    end
    if test $count_ahead -ne 0
        echo -n ' '(set_color brmagenta)"⬆$count_ahead"
    end
    if test $count_behind -ne 0
        echo -n ' '(set_color brmagenta)"⬇$count_behind"
    end
    if test $status_stashed -ne 0
        echo -n ' '(set_color cyan)'✭'
    end
    if test $count_added -ne 0
        echo -n ' '(set_color green)"✚$count_added"
    end
    if test $count_deleted -ne 0
        echo -n ' '(set_color red)"✖$count_deleted"
    end
    if test $count_modified -ne 0
        echo -n ' '(set_color blue)"✱$count_modified"
    end
    if test $count_renamed -ne 0
        echo -n ' '(set_color magenta)"➜$count_renamed"
    end
    if test $count_unmerged -ne 0
        echo -n ' '(set_color yellow)"═$count_unmerged"
    end
    if test $count_untracked -ne 0
        echo -n ' '(set_color white)"◼$count_untracked"
    end
    if test $count_ignored -ne 0
        echo -n ' '(set_color white)"•"
    end

    set_color normal
    echo -n ')'
end

function fish_prompt
    # Always set this first. Otherwise the following commands will
    # overwrite the previous command's exit status.
    set -l cmd_status $status

    if test $cmd_status -ne 0
        echo -n (set_color red)"✘ $cmd_status "
    end

    if test -n "$SSH_TTY"
        echo -n (set_color brred)"$USER"(set_color white)'@'(set_color yellow)(prompt_hostname)' '
    end

    echo -n (set_color -o FF8000)(prompt_pwd -d 0)' '

    custom_git_prompt

    echo

    set_color -o
    if fish_is_root_user
        echo -n (set_color red)'# '
    end
    echo -n (set_color red)'❯'(set_color yellow)'❯'(set_color green)'❯ '
    set_color normal
end
