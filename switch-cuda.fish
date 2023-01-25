# Copyright (c) 2023 Patrick Hohenecker and Jakob D. Havtorn

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# author:   Patrick Hohenecker (bash version)
#           Jakob D. Havtorn (fish version)
# version:  2023.1
# date:     January 25, 2023


# ensure that the script has been sourced rather than just executed
if test "$_" != source;
    echo "Please use 'source' to execute switch-cuda.fish!"
    exit 1
end

set INSTALL_FOLDER "/usr/local"  # the location to look for CUDA installations at
set TARGET_VERSION $argv[1]          # the target CUDA version to switch to (if provided)

# if no version to switch to has been provided, then just print all available CUDA installations
if [ -z "$TARGET_VERSION" ];
    echo "The following CUDA installations have been found (in '$INSTALL_FOLDER'):"
    ls -l "$INSTALL_FOLDER" | egrep -o "cuda-[0-9]+\\.[0-9]+" | while read -l foo;
        echo "* $foo"
    end
    exit 0
# otherwise, check whether there is an installation of the requested CUDA version
else if [ ! -d "$INSTALL_FOLDER/cuda-$TARGET_VERSION" ];
    echo "No installation of CUDA $TARGET_VERSION has been found!"
    exit 1
end

# the path of the installation to use
set cuda_path "$INSTALL_FOLDER/cuda-$TARGET_VERSION"

# filter out those CUDA entries from the PATH that are not needed anymore
set new_path "$cuda_path/bin"
for p in $PATH;
    if ! string match -q -r "$INSTALL_FOLDER/cuda*" $p
        set new_path "$new_path:$p"
    end
end

# filter out those CUDA entries from the LD_LIBRARY_PATH that are not needed anymore
set new_ld_path "$cuda_path/lib64:$cuda_path/extras/CUPTI/lib64"
for p in $LD_LIBRARY_PATH;
    if ! string match -q -r "$INSTALL_FOLDER/cuda*" $p
        set new_ld_path "$new_ld_path:$p"
    end
end

# # update environment variables
set -x CUDA_HOME $cuda_path
set -x CUDA_ROOT $cuda_path
set -x LD_LIBRARY_PATH $new_ld_path
set -x PATH $new_path

echo "Switched to CUDA $TARGET_VERSION."

exit 0
