# send_code sends the code from zeus to apollo
alias send_code='rsync -avuz --rsync-path=/usr/bin/rsync --delete --exclude=.snapshots/ ~/code/ apollo:/volume1/Code/active/'
# get_code sends the code from apollo to zeus
alias get_code='rsync -avuz --rsync-path=/usr/bin/rsync --delete --exclude=.snapshots/ apollo:/volume1/Code/active/ ~/code/'
