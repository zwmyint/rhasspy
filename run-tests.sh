#!/usr/bin/env bash

export LC_ALL=C.UTF-8
export LANG=C.UTF-8

# Directory of *this* script
this_dir="$( cd "$( dirname "$0" )" && pwd )"
venv="${this_dir}/.venv"

if [[ ! -d "${venv}" ]]; then
    echo "Missing virtual environment at ${venv}"
    echo "Did you run create-venv.sh?"
    exit 1
fi

# Force .venv/lib to be used
export LD_LIBRARY_PATH="${venv}/lib:${LD_LIBRARY_PATH}"

# Use local Kaldi
if [[ -d "${this_dir}/opt/kaldi" ]]; then
    export KALDI_PREFIX="${this_dir}/opt"
fi

# Path to sphinxtrain tools
if [[ -d "/usr/lib/sphinxtrain" ]]; then
    export PATH="/usr/lib/sphinxtrain:${PATH}"
fi

cd "${this_dir}"
source "${venv}/bin/activate"
python3 test.py "$@"
