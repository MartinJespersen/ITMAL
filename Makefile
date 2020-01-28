DAV = /mnt/Dav/ITMAL
DIR = $(DAV)/"File Sharing"
TEXDIR=/home/cef/ASE/ITMAL/TeX

pub: hasDAV
	@ echo "CP lessons, local.."
	@ cp -v -u $(TEXDIR)/lesson01.pdf L01/lesson01.pdf
	@ echo "CP lessons, remote.."
	@ cp -v -u -r L?? $(DIR)
	@ echo "CP libitmal, remote.."
	@ cp -v -u -r libitmal $(DIR)
	@ git st
	@ echo -n "Server itu git pull.." && (ssh itu "cd F20_itmal && git pull") || echo "failed"
	@ echo "ALL OK"

update:
	@ git status
	@ ssh -A -Y itu "cd F20_itmal && git pull"

hasDAV:
	@ cat /proc/mounts | grep $(DAV) >/dev/null || (echo "ERROR: DAV dir $(DAV) not mounted" && false)	

diff: hasDAV
	diff -dwqr -x '*~' -x '.git*' -x 'Makefile' -x 'Solutions' -x 'Old' -x 'Src' -x 'datasets' . $(DIR) || echo "DIFFS(1)!"
	diff  $(TEXDIR)/lesson01.pdf L01/lesson01.pdf || echo "DIFFS(2)!"
	@ echo "OK"

#lessons:
#	cp -u $(TEXDIR)/lesson01.pdf L01/lesson01.pdf

clean:
	find . -iname '.ipynb_checkpoints' -exec rm -rf {} \; || true
	find . -iname '__pycache__' -exec rm -rf {} \; || true
	find $(DIR) -iname '.ipynb_checkpoints' -exec rm -rf {} \; || true
	
#cp lessons..
#'L01/demo.ipynb' -> '/mnt/Dav/ITMAL/File Sharing/Src/L01/demo.ipynb'
#'L01/.ipynb_checkpoints' -> '/mnt/Dav/ITMAL/File Sharing/Src/L01/.ipynb_checkpoints'
#'L01/.ipynb_checkpoints/demo-checkpoint.ipynb' -> '/mnt/Dav/ITMAL/File Sharing/Src/L01/.ipynb_checkpoints/demo-checkpoint.ipynb'
#'L02/cost_function.ipynb' -> '/mnt/Dav/ITMAL/File Sharing/Src/L02/cost_function.ipynb'
#'L02/.ipynb_checkpoints' -> '/mnt/Dav/ITMAL/File Sharing/Src/L02/.ipynb_checkpoints'
#'L02/.ipynb_checkpoints/cost_function-checkpoint.ipynb' -> '/mnt/Dav/ITMAL/File Sharing/Src/L02/.ipynb_checkpoints/cost_function-checkpoint.ipynb'
#cp libitmal..
		