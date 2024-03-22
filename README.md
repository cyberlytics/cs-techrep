
# cs-techrep - Technical Reports in Computer Science and Software Engineering

This repository hosts the source code for the [CTAN](https://ctan.org/) package [cs-techrep](https://ctan.org/pkg/cs-techrep).


This package provides a class for the creation of technical reports in computer science and software engineering. The style is a two-column format similar to IEEE. It is intended for lab reports and provides a beginner-friendly template example.


DISCLAIMER: The cs-techrep class requires latex/pdflatex in combination with biblatex using a biber backend. This cs-techrep class does not support XeLaTeX or LuaTeX nor legacy bibtex or natbib.

If you just want to extend you LaTeX installation please download the [cs-techrep package from CTAN](https://ctan.org/pkg/cs-techrep) and follow the installation instructions.

If you want to extend the package please follow this guideline.

## Building the package

To build the package from source clone this repository:

```bash
$ git clone https://github.com/cyberlytics/cs-techrep.git
```

and run `make`:

```bash
$ make dist
```

This will create the zip file `dist/cs-techrep.zip` with the complete installation package as it can be downloaded from CTAN.

All build artifacts without the archive itself can be build with:

```bash
$ make compile
```

The repository can be cleaned up with:

```bash
$ make clean
```

## The source files

* `dependencies/` contains third party tools that are needed for compilation
* `doc/cs-techrep.tex` The user documentation of the cs-techrep class
* `patch/` Files needed for patching generated artifacts
* `src/cs-techrep.cls` The LaTeX class of the package
* `static` All files that will be added unchanged to the CTAN package like `README` and template sources

## Build artifacts

All build artifacts can be found in `build`. The `Makefile` builds the following artifacts:

* `cs-techrep.ins` and `cs-techrep.dtx` which contains the LaTeX installation package and the documentation source.
* `cs-techrep.pdf` the documentation of the class
* `*-example-*.pdf` include TEX+PDF example based on this class

## Build dependencies

The build environment needs the following Unix tools to be installed:

* GNU make
* LaTeX (inclduding `latexmk`)
* perl
* Unix commandline: bash, echo, cp, mv, rm, ed, cut, mkdir, head

## Contact

* [Christoph P. Neumann <cyberpetaneuron@gmail.com>](mailto:cyberpetaneuron+cstechrep@gmail.com)