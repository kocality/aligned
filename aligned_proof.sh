#!/bin/bash

# Define colors
RED="\033[31m"
YELLOW="\033[33m"
GREEN="\033[32m"
NORMAL="\033[0m"

# Message
echo -e "${GREEN}This script was made with love by @kkocality <3${NORMAL}"
sleep 8

install_dependencies() {
    echo -e "${YELLOW}Installing System Updates${NORMAL}"
    sudo apt update -y && sudo apt upgrade -y
    sudo apt-get install curl -y
}

install_alignedlayer() {
    echo -e "${YELLOW}Installing AlignedLayer${NORMAL}"
    curl -L https://raw.githubusercontent.com/yetanotherco/aligned_layer/main/batcher/aligned/install_aligned.sh | bash
    echo 'export PATH=$PATH:$HOME/.aligned/bin' >> $HOME/.bashrc
    source $HOME/.bashrc
}

download_proof_files() {
    echo -e "${YELLOW}Downloading proof files${NORMAL}"
    curl -L https://raw.githubusercontent.com/yetanotherco/aligned_layer/main/batcher/aligned/get_proof_test_files.sh | bash
}

submit_proof() {
    echo -e "${YELLOW}Submitting proof${NORMAL}"
    rm -rf ~/aligned_verification_data/ &&
    $HOME/.aligned/bin/aligned submit \
    --proving_system SP1 \
    --proof ~/.aligned/test_files/sp1_fibonacci.proof \
    --vm_program ~/.aligned/test_files/sp1_fibonacci-elf \
    --aligned_verification_data_path ~/aligned_verification_data \
    --conn wss://batcher.alignedlayer.com
}

main() {
    install_dependencies
    install_alignedlayer
    source $HOME/.bashrc  # Ensure the new PATH is sourced
    download_proof_files
    submit_proof
    echo -e "${GREEN}Proof successfully created. It may take a few seconds for the status to be verified.
You can check it via explorer with the link provided.

Stay #aligned!${NORMAL}"
}

# Execute the main function
main
