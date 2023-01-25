switch-cuda
===========

> This script is a port to `fish` of the `bash` version by Patrick Hohenecker available at https://github.com/phohenecker/switch-cuda.

Sometimes, it becomes necessary to switch to an earlier version of CUDA in order to run older code on a machine that is
actually set up to use the current version of the CUDA toolkit.
This is as simple as adjusting the values of a few environment variables, yet it is cumbersome to do manually.
Therefore, this repository provides the fish script [`switch-cuda.fish`](switch-cuda.fish), which adjusts the environment to
use a specific version of CUDA **for the current fish session**.

**Notice:** [`switch-cuda.fish`](switch-cuda.fish) has been written for and tested on Ubuntu 16.04, but is easily adapted
for other platforms.


Usage
-----

```
source switch-cuda.fish [VERSION]
```

Notice that the script has to be sourced rather than executed, as it performs changes of environment variables that are
supposed to persist after the script has finished.
If a version number is provided, than all relevant environment variables are adjusted to the required CUDA version
(including `PATH`, `LD_LIBRARY_PATH`, `CUDA_HOME`, and `CUDA_ROOT`).
If no version is provided, however, then the script simply prints all versions of CUDA that have been found on the used
machine (in `/usr/local`).


Examples
--------

```
$ source switch-cuda.fish 
The following CUDA installations have been found (in '/usr/local'):
* cuda-8.0
* cuda-9.0
* cuda-9.1
```

```
$ source switch-cuda.fish 9.0
Switched to CUDA 9.0.
```

Copyright (c) 2023 Patrick Hohenecker and Jakob D. Havtorn

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

author:   Patrick Hohenecker (bash version)
          Jakob D. Havtorn (fish version)
version:  2023.1
date:     January 25, 2023
