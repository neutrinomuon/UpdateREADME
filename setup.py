from setuptools import Extension
from setuptools import setup

with open("README.md", "r") as fh:
    long_description = fh.read()

setup( name='TreeHue',
       version='0.0.1',
       description='TreeHue is a Python package for visually enhancing directory tree structures with color-coded representations.',
       long_description=long_description,      # Long description read from the the readme file
       long_description_content_type="text/markdown",
       author='Jean Gomes',
       author_email='antineutrinomuon@gmail.com',
       url='https://github.com/neutrinomuon/TreeHue',
       install_requires=[ 'numpy','matplotlib' ],
       classifiers=[
           "Programming Language :: Python :: 3",
           "Operating System :: OS Independent",
                   ],
       package_dir={"TreeHue": "src/python"},
       packages=['TreeHue'],
       data_files=[('', ['version.txt']),],
      )
    
