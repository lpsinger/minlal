import subprocess
import glob, os

fnames = glob.glob('*.so') + glob.glob('*.dylib')

def get_deps(lib):
    output = subprocess.check_output("otool -L %s" % lib, shell=True)
    names = output.split('\n')[1:]
    n = [a.split(' ')[0].strip() for a in names if a != '']
    n = [a for a in n if 'libSystem' not in a]
    return n

inames = []
for fname in fnames:
    print get_deps(fname)
    output = subprocess.check_output("otool -D %s" % fname, shell=True)
    red = output.split('\n')[1].strip()
    if red != '':
        inames.append(red)

for fname in fnames:
    deps = get_deps(fname)
    for dep in deps:
         base = os.path.basename(dep)
         subprocess.call("install_name_tool -change \"%s\" @loader_path/%s %s" % (dep, base, fname), shell=True)

