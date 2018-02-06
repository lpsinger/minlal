set -e
export PATH=$PATH:$PWD/local/bin:$HOME/Library/Python/3.4/bin:$HOME/.local/bin

python setup.py bdist_wheel
ls dist

virtualenv env
source env/bin/activate
pip install dist/*.whl

python test.py
