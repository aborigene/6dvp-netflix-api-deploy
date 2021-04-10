# O que é esse repositório?

Aqui ficam os arquivos terraform para o deploy de toda a plataforma de APIs. Será feito todo o deploy no K8S deixando a API pronta para uso.

## Status

Nesse momento somente os serviços abaixo estão configurados:

product-details
auth
auth-db

## Como usar esse repositório

1. Executar os comandos terraform, como abaixo

```
cd product-details
terraform init
terraform plan
terraform apply --auto-aprove
```

Será usada a configuração de acesso do Kubernetes configurada localmente.

Os arquivos estão configurados para baixar as imagens do repoistório projeto no Docker Hub, para construir o serviços e usar suas próprias imagens basta rodar o maven de cada serviço do projeto e atualizar os valores das imagens no arquivo terraform.

## Requisitos e recomendações

1. Um cluster K8S funcionando e para o qual se tenha acesso
2. Recomendamos para testes o uso do minikube, basta instalar e configurar o minikube que o deploy será feito a este ambiente corretamente usando os arquivos destes repositório
3. Para acessar os serviços é necessária a configuração de LoadBalancers, Port Forwarding ou Tunnel. Por favor verificar a documentação do ambiente onde está sendo feito o deploy, para a melhor opção a ser usada.
4. Por exemplo, no caso do Minikube e o serviço product-details basta executar o comando abaixo, que irá garantir o acesso ao serviço através da porta local 8080. Caso esta porta já esteja em uso, ajustar o comando para uma porta que esteja disponível.
5. Necessário terraform instalado localmente para execução do deploy.

```
kubectl port-forward service/dvp6-netflix-product-details 8080:8083 -n dvp6-netflix-product-details
```

## TODO:

Automação geral desse processo e extensão aos demais serviços.