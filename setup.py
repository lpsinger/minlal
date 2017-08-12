from setuptools import setup

from wheel.bdist_wheel import bdist_wheel as _bdist_wheel

class bdist_wheel(_bdist_wheel):
    def finalize_options(self):
        _bdist_wheel.finalize_options(self)
        self.root_is_pure = False

setup(name='lal',
      version='0.0.4',
      description='LIGO Algorithm Library for Python',
      author='Alex Nitz',
      author_email='alex.nitz@aei.mpg.de',
      install_requires=['numpy==1.13.0'],
      package_data={'blal': ['*.so*']},
      packages=['lal', 'lalsimulation', 'lalframe', 'blal'],
      cmdclass={'bdist_wheel': bdist_wheel},
     )
