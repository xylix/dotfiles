echo "This is in testing remove if not working"
nvidia-settings --assign CurrentMetaMode="DPY-5: nvidia-auto-select +0+0 {ForceCompositionPipeline=On}, DPY-7: nvidia-auto-select +2560+0 {ForceCompositionPipeline=On}"
~/dotfiles/scripts/freedomscreenlayout.sh
dispwin -v -L
xinput --set-prop 'Logitech Gaming Mouse G502' 'libinput Accel Profile Enabled' 0, 1
exec i3
