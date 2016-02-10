#!/bin/bash
docker images
read -p "Quel docker utiliser ? : " docker

read -p "Utiliser une IP ? (y/n) : " ip

case $ip in
    'y' )
    read -p "Adresse IP : " newip
    read -p "Masque (CIDR) : " cidr
    ip addr add brd + dev docker0 $newip/$cidr
    read -p "Port à rediriger : " port
    read -p "Monter un dossier ? (y/n) : " mount
    case $mount in
        'y' )
        read -p "Quel dossier (chemin complet) : " folder
        read -p "Shell (bash/zsh) : " shell
        docker rm container
        docker run --privileged=true -it -v $folder:/mnt --name container -p $newip:$port:$port -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix $docker /bin/$shell
        exit 0
        ;;
        'n' )
        read -p "Shell (bash/zsh) : " shell
        docker run --privileged=true -it -p $newip:$port:$port -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix $docker /bin/$shell
        exit 0
        ;;
        default )
        echo "Erreur"
        exit 1
        ;;
    esac
    ;;
    'n' )
    read -p "Monter un dossier ? (y/n) : " mount
    case $mount in
        'y' )
        read -p "Quel dossier (chemin complet) : " folder
        read -p "Shell (bash/zsh) : " shell
        docker rm container
        docker run --privileged=true -it -v $folder:/mnt --name container -p $newip -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix $docker /bin/$shell
        exit 0
        ;;
        'n' )
        read -p "Shell (bash/zsh) : " shell
        docker run --privileged=true -it -p $newip:5000:5000 -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix $docker /bin/$shell
        exit 0
        ;;
        default )
        echo "Erreur"
        exit 1
        ;;
    esac
    exit 0
    ;;
    default )
    echo "Erreur"
    exit 1
    ;;
esac
;;
'n' )
read -p "Monter un dossier ? (y/n) : " mount
case $mount in
    'y' )
    read -p "Quel dossier (chemin complet) : " folder
    read -p "Shell (bash/zsh) : " shell
    docker rm container
    docker run --privileged=true -it -v $folder:/mnt --name container -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix $docker /bin/$shell
    exit 0
    ;;
    'n' )
    read -p "Shell (bash/zsh) : " shell
    docker run --privileged=true -it -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix $docker /bin/$shell
    exit 0
    ;;
    default )
    echo "Erreur"
    exit 1
    ;;
esac
;;
default )
echo "Erreur"
exit 1
;;
esac
