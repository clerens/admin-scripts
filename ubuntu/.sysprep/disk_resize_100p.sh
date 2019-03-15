#!/bin/bash

# Script to automatically resize default ubuntu-lv to 100%

# Test if script is executed as root

if [ "$EUID" -ne 0 ]
  then
    echo -e "Essaye plus avec sudo pour voir si ca fonctionne ;)."
    exit
fi


echo -e "\e[31mAttention: Vous êtes sur le point de redimensionner à 100% le volume logique:"
df -h | grep /dev/mapper/ubuntu--vg-ubuntu--lv
echo -e "N'oubliez pas de faire une sauvegarde ou un cliché instantannée de VMware avant de procéder.\e[0m"

echo -n "Voulez-vous continuez? [o/N] default [N]: "

read answer

lc_answer=${answer,,}

if [ "$lc_answer" == "o" ];
  then
    echo -e "\e[33mExtension du volume physique /dev/sda3...\e[0m"
    parted /dev/sda resizepart 3 100%
    pvresize /dev/sda3
    echo -e "\e[33mExtension du volume group /dev/ubuntu-vg/ubuntu-lv...\e[0m"
    lvextend -l+100%FREE /dev/ubuntu-vg/ubuntu-lv
    echo -e "\e[33mRedimensionement du système de fichier /dev/mapper/ubuntu--vg-ubuntu--lv...\e[0m"
    resize2fs /dev/mapper/ubuntu--vg-ubuntu--lv
    df -h | grep /dev/mapper/ubuntu--vg-ubuntu--lv
    echo -e "Opération terminée."
  else
    echo "Opération annulée."
fi
