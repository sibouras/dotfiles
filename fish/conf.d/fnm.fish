set FNM_PATH "$HOME/.local/share/fnm"
if [ -d "$FNM_PATH" ]
  fish_add_path $FNM_PATH
  fnm env --shell fish | source
end

# clean cache directory on shell exit, https://github.com/Schniz/fnm/issues/696
function fnm_clean_up --on-event fish_exit
    # Temporary debug log to prove the event is firing
    # echo -e "Fish exited at $(date)\nenv = $FNM_MULTISHELL_PATH" >> ~/.config/fish/exit_debug.log

    # Safely remove the directory only if the variable exists and is a directory
    if test -n "$FNM_MULTISHELL_PATH"; and test -d "$FNM_MULTISHELL_PATH"
        rm -rf "$FNM_MULTISHELL_PATH"
    end
end
