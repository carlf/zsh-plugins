#!/bin/sh

_emacsfun()
{
    # get list of emacs frames.
    frameslist=`emacsclient --alternate-editor '' --eval '(frame-list)' 2>/dev/null | egrep -o '(frame)+'`

    if [ "$(echo "$frameslist" | sed -n '$=')" -ge 1 ] ;then
        # prevent creating another X frame if there is at least one present.
        emacsclient --alternate-editor "" "$@"
    else
        # Create one if there is no X window yet.
        emacsclient --alternate-editor "" --create-frame "$@"
    fi
}


# adopted from https://github.com/davidshepherd7/emacs-read-stdin/blob/master/emacs-read-stdin.sh
# If the second argument is - then write stdin to a tempfile and open the
# tempfile. (first argument will be `--no-wait` passed in by the plugin.zsh)
if [ "$#" -ge "2" -a "$2" = "-" ]
then
    tempfile="$(mktemp --tmpdir emacs-stdin-$USERNAME.XXXXXXX 2>/dev/null \
                || mktemp -t emacs-stdin-$USERNAME)" # support BSD mktemp
    cat - > "$tempfile"
    _emacsfun --no-wait $tempfile
else
    _emacsfun "$@"
fi
