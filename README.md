# lal

Python binary distribution of a minimum set of lalsuite tools

## Version number

The version number has two parts: the LALSuite version number and possibly a
minlal revision number. The minlal revision number is treated as a
[post-release number in the manner described by PEP 440][1].

For example, suppose that there is a LALSuite release 6.48. Then each time the
minlal package is updated, the resulting Python package will have the following
version numbers:

1.  `6.48`
2.  `6.48.post1`
3.  `6.48.post2`
4.  `6.48.post3`
5.  etc.

[1]: https://www.python.org/dev/peps/pep-0440/#post-release-spelling
