set -e

python setup.py bdist_wheel
ls dist

virtualenv env
source env/bin/activate
pip install dist/*.whl

python test.py
