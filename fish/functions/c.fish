function c
    set -l dirs ~/{Code/*,Code/ps/*}
    set -l directory (command ls -d -1 $dirs 2>/dev/null | fzf --tiebreak=length,begin,end)
    if test -n "$directory"
        and test -d $directory
        cd $directory
    end
end
