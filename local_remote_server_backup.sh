#!/bin/bash

#verify user is root
if [ $(id -u) -ne 0 ]
then
	echo "You need to have root permission to continue"
	exit 1
fi

#function to let the user know of the required options to run the script
usage() {
	echo "You can run this script with different flags as arguments"
	echo "Enter the full path of the directory or file you intend to transfer
	The remote/client destination is pre-determined
	Note:incluse a '/' at the end of the path if you want only the files and not the entire directory to 
	be transfered"
	echo "enter the user and ip address of the remote server"
	echo "use 'd' for --delete: Synchronize and delete files not present in the source" 
	echo "A: for host to remote/client synchronization"
	echo "B: for remote/client to host synchronization"
	echo "For example: /local/file/path user@192.168.1.x:/remote/destination/path A d"
	echo "Enter the source path (with or without slash at the end. Slash only copies files in the directory, no slash copies the directory and its files): "
	

}

#key required arguments
# $1 = file or directory to be synchronized
# $2 = remote user and destination path or local destination path
# $3 = A or B for either local synchronization or remote synchronization
# $4 = any preferred rsync options user prefers

#variables
HOST_PATH=$1
RSYNC_TYPE=$3
RSYNC_OPTIONS=$4
REMOTE_PATH=$2

#verify directory or file to be backed up is provided

if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]
then
	echo "You must provide the path to a directory or file that you want to backup, the destination and choose either a remote or local synchronizationi"
	usage
	exit 1
else
	if [ -d "$1" ] 
	then
		if [ "$3" = "A" ]
		then
			if [ "$4" = "d" ]
			then
			 	#use host to client synchrony selected by user
                        	rsync -azvi $RSYNC_OPTIONS $HOST_PATH $REMOTE_PATH
                        	echo "You successfully synchronized your files from server to remote client with the delete option"
			else
				 #use host to client synchrony selected by user
                                rsync -azvi $HOST_PATH $REMOTE_PATH
				echo "You successfully synchronized your files from server to remote client"
			fi
                elif [ "$3" = "B"]
                then
			if [ "$4" = "d" ]
                        then

                        	#use client to host synchrony selected by user
                        	rsync -azvi $RSYNC_OPTIONS $REMOTE_PATH $HOST_PATH
                        	echo "You successfully synchronized your files from remote client to your server 
					with the delete option"
			 else
                                 #use client to host synchrony selected by user
                                rsync -azvi $REMOTE_PATH $HOST_PATH
                                echo "You successfully synchronized your files from remote client to server"
			fi
		fi
	else
		echo "You must enter an existing directory path"
		exit 1 
	fi
fi

#verify the script was successful
if [ $? -eq 0 ]
then
	echo "The synchronization was successful"
	exit 0
else
	echo "The synchronization was not successful, please try again and follow all the required argument rules"
	exit 1
fi

#use ssh-keygen the ssh-copy-id TO CREATE AUTOMATIC SSH CONNECTIONS FOR RSYNC TRANSFER
#rsync -azvi , i FOR listing changes in both the host and remote files
#rsync -azv --delete or --existing
#rsync -azv --include='*.txt' --exclude='*.sh'
#rsync -azv -e "ssh -p 2222" path/file/ 192.168.x.x:~/home/bugie
#(for big files transfer)rsync -azv -e --progress "ssh -p 2222" path/file/ 192.168.x.x:~/home/bugie





