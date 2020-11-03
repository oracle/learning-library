ssh-keygen -f ./id_rsa -N ""
openssl genrsa -out ./api_key 2048
openssl rsa -pubout -in ./api_key -out ./api_key.pub
