DAV = /mnt/Dav/ITMAL
DIR = $(DAV)/"File Sharing"/Src/

pub: hasDAV
	cp -v -u -r L?? $(DIR)
	cp -v -u -r libitmal $(DIR)

hasDAV:
	@ cat /proc/mounts | grep $(DAV) >/dev/null || (echo "ERROR: DAV dir $(DAV) not mounted" && false)	

diff: hasDAV
	diff -dwqr -x '*~' -x '.git*' -x 'Makefile' -x 'Solutions' -x 'Old' -x 'Src' -x 'datasets' . $(DIR)

clean:
	find . -iname '.ipynb_checkpoints' -exec rm -rf {} \; || true
	find . -iname '__pycache__' -exec rm -rf {} \; || true
	find $(DIR) -iname '.ipynb_checkpoints' -exec rm -rf {} \; || true
	
		