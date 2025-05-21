# Use emacs-like key bindings by default:           804
bindkey -e
bindkey '^[[7~' beginning-of-line                               # Home key
bindkey '^[[H' beginning-of-line                                # Home key
if [[ "${terminfo[khome]}" != "" ]]; then
  bindkey "${terminfo[khome]}" beginning-of-line                # [Home] - Go to beginning of line
fi
bindkey '^[[8~' end-of-line                                     # End key
bindkey '^[[F' end-of-line                                      # End key
if [[ "${terminfo[kend]}" != "" ]]; then
  bindkey "${terminfo[kend]}" end-of-line                       # [End] - Go to end of line
fi
bindkey '^[[2~' overwrite-mode                                  # Insert key
bindkey '^[[3~' delete-char                                     # Delete key
bindkey '^[[C'  forward-char                                    # Right key
bindkey '^[[D'  backward-char                                   # Left key
bindkey '^[Oc' forward-word                                     #
bindkey '^[Od' backward-word                                    #
bindkey '^[[1;5D' backward-word                                 #
bindkey '^[[1;5C' forward-word                                  #
bindkey '^H' backward-kill-word                                 # delete previous word with ctrl+backspace
bindkey '^[[Z' undo                                             # Shift+tab undo last action


# if zrcgotkeymap menuselect; then
#     #m# k Shift-tab Perform backwards menu completion
#     bind2maps menuselect -- BackTab reverse-menu-complete

#     #k# menu selection: pick item but stay in the menu
#     bind2maps menuselect -- -s '\e^M' accept-and-menu-complete
#     # also use + and INSERT since it's easier to press repeatedly
#     bind2maps menuselect -- -s '+' accept-and-menu-complete
#     bind2maps menuselect -- Insert accept-and-menu-complete

#     # accept a completion and try to complete again by using menu
#     # completion; very useful with completing directories
#     # by using 'undo' one's got a simple file browser
#     bind2maps menuselect -- -s '^o' accept-and-infer-next-history
# fi
