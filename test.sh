set -e
export PATH=$PATH:$PWD/local/bin:$HOME/Library/Python/2.7/bin:$HOME/.local/bin

python setup.py bdist_wheel
ls dist

virtualenv env
source env/bin/activate
pip install -q dist/*.whl

python test.py
