function take-backup --description "Take a local backup of github folders"
	if test -f $HOME/.github-backup.conf
		echo ".github-backup.conf exists"
	else
		echo "[github-backup] \nAPITOKEN=" > $HOME/.github-backup.conf
		echo "Place github token in $HOME/.github-backup.conf"
		echo "Tokens can be created at https://github.com/settings/tokens"
		echo "Remember to grant read permissions to everything except organization content"
	end
	mkdir -p $HOME/Code/github-backup
	cd $HOME/Code/github-backup
	python3 -m venv venv
	source venv/bin/activate.fish
	pip install git+https://github.com/clockfort/GitHub-Backup

	# With debug prints
	# python ./github_backup/github_backup.py xylix github-xylix-backupdir -d --visibility private 
	python ./github_backup/github_backup.py xylix github-xylix-backupdir --visibility all -p -d --account
	if test -d ./github-xylix-backupdir/repositories/logseq-database
		echo "Succesfully backed up, including private repos"
	else
		echo "Did not backup some private repos. Could be auth / token problem."
	end
end
