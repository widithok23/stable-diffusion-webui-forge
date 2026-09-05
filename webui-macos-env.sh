#!/bin/bash
####################################################################
#                          macOS defaults                          #
# Please modify webui-user.sh to change these instead of this file #
####################################################################

export install_dir="$HOME"
export COMMANDLINE_ARGS="--skip-torch-cuda-test --upcast-sampling --no-half-vae --use-cpu interrogate"
export PYTORCH_ENABLE_MPS_FALLBACK=1

# Use a Python 3.13 compatible torch on newer runtimes, otherwise fall back to the tested pair.
pyv="$(${python_cmd:-python3} -c 'import sys; print(f"{sys.version_info[0]}.{sys.version_info[1]}")' 2>/dev/null)"
if [[ "$pyv" == "3.13" ]]; then
    export TORCH_COMMAND="pip install torch==2.5.1 torchvision==0.20.1"
elif [[ "$(sysctl -n machdep.cpu.brand_string)" =~ ^.*"Intel".*$ ]]; then
    export TORCH_COMMAND="pip install torch==2.1.2 torchvision==0.16.2"
else
    export TORCH_COMMAND="pip install torch==2.3.1 torchvision==0.18.1"
fi

####################################################################
