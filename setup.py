#!/usr/bin/python
from distutils.core import setup

setup(
    name="movier",
    version="0.4.0",

    author="Miroslav Prasil",
    author_email="miroslav@prasil.info",
    url="https://github.com/mprasil/movier",

    include_package_data=True,

    license="GPLv2 or later",
    description="Move movies to your library with proper name and subtitle encoding.",
    long_description=open('README.rst').read(),


    install_requires=[
        "chardet",
    ],

    classifiers=[
        "Development Status :: 3 - Alpha",
        "Environment :: Console",
        "Topic :: Utilities",
        "License :: OSI Approved :: GNU General Public License v2 or later (GPLv2+)",
        "Programming Language :: Python :: 3",
        "Programming Language :: Python :: 3.11",
        "Programming Language :: Python :: 3.12",
    ],

    scripts=["movier"]

)

