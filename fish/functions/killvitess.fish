function killvitess
    set -l vtdata_root $VTDATAROOT
    if test -z $VTDATAROOT
        set vtdata_root $TMPDIR
    end

    echo $vtdata_root

    killall -9 vttestserver &>/dev/null
    killall -9 vtcombo &>/dev/null

    for pid_file in $vtdata_root**
        if string match -q -r 'vt_0000000001/mysql.pid' $pid_file
            set -l pid (cat $pid_file)
            kill -9 $pid
            rm -rf $pid_file
        end
    end

    echo "done!"
end
