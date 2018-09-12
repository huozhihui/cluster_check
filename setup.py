#!/usr/bin/python
# -*- coding: utf-8 -*-
import codecs
import os
import re

try:
    from setuptools import setup
except ImportError:
    from distutils.core import setup


def fpath(name):
    return os.path.join(os.path.dirname(__file__), name)


def read(fname):
    return codecs.open(fpath(fname), encoding='utf-8').read()


def grep(attrname):
    pattern = r"{0}\W*=\W*'([^']+)'".format(attrname)
    strval, = re.findall(pattern, file_text)
    return strval


file_text = read(fpath('cluster_check/__init__.py'))

setup(
    name='cluster_check',
    version=grep('__version__'),
    description='Storage cluster check.',
    long_description=read(fpath('README.rst')),
    url='https://github.com/huozhihui/cluster_check',
    author='Huozhihui',
    author_email="240516816@qq.com",
    license='Apache 2.0',
    packages=['cluster_check'],
    zip_safe=False,
    install_requires=[
    ],
    extras_require={
        # ":python_version=='2.7'": ['backports.functools_lru_cache>=1.2.1'],
    },
    # test_suite="tests",
    classifiers=[
        'Development Status :: 4 - Beta',
        'Intended Audience :: Developers',
        'License :: OSI Approved :: Apache Software License',
        'Programming Language :: Python :: 2.6',
        'Programming Language :: Python :: 2.7',
        # 'Programming Language :: Python :: 3.3',
        # 'Programming Language :: Python :: 3.4',
        # 'Programming Language :: Python :: 3.5',
        'Topic :: Software Development :: Libraries :: Python Modules'
    ],
    entry_points={
        'console_scripts': [
            'cluster_check = cluster_check.xj:main'
        ]
    },
    platforms='any'
)