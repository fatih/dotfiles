function _copy_feedback --description 'Transient tmux status message after a clipboard copy'
    # Only meaningful inside tmux; harmless no-op otherwise.
    set -q TMUX; or return

    set -l label $argv[1]
    # Flatten to one line so a multi-line command line still fits the status bar.
    set -l value (string join ' ' -- $argv[2..-1] | string replace -a \n ' ' | string collect)

    set -l max 60
    if test (string length -- "$value") -gt $max
        set value (string sub -l $max -- "$value")…
    end
    test -z "$value"; and set value '(empty)'

    # tmux reads '#' as a format escape; double it so the value shows literally.
    set value (string replace -a '#' '##' -- "$value")

    tmux display-message "📋 copied $label: $value"
end
