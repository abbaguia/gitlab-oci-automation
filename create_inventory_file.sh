
#!/usr/bin/bash

echo -e "\n Checking to see if the inventory file /home/mail2maham/demo1/ansible/tf_inventory.yaml exisits"

if [ -f "~/tensorflow-demo-sanjose/tf_inventory.yaml" ]; 
then
    echo -e "\n Found ~/tensorflow-demo-sanjose/tf_inventory.yaml, it will be deleted"
    rm ~/tensorflow-demo-sanjose/tf_inventory.yaml
    echo -e "\n Checking to verify that it is deleted ..... "
    pwd
    ls -ltr
fi
echo -e "\n Creating the ~/tensorflow-demo-sanjose/tf_inventory.yaml now ...." 
touch ~/tensorflow-demo-sanjose/tf_inventory.yaml
echo -e "[servers]" > ~/tensorflow-demo-sanjose/tf_inventory.yaml
pwd
ls -ltr

cat ~/tensorflow-demo-sanjose/tf_inventory.yaml
