# O que é esse repositório?

Aqui ficam os arquivos terraform para o deploy de toda a plataforma de APIs. Será feito todo o deploy no K8S deixando a API pronta para uso.

## Status

Nesse momento somente a API product-details está configurada

## Como usar esse repositório

1. Entrar no diretório da API que se quer fazer o deploy.
2. Executar os comandos terraform

```
cd product-details
terraform init
terraform plan
terraform apply --auto-aprove
```

Será usada a configuração de acesso do Kubernetes configurada localmente.

## Requisitos e recomendações

1. Um cluster K8S funcionando e para o qual se tenha acesso
2. Recomendamos para testes o uso do minikube, basta instalar e configurar o minikube que o deploy será feito a este ambiente corretamente usando os arquivos destes repositório
3. Para acessar os serviços é necessária a configuração de LoadBalancers, Port Forwarding ou Tunnel. Por favor verificar a documentação do ambiente onde está sendo feito o deploy, para a melhor opção a ser usada.
4. No caso do Minikube e o serviço product-details basta executar o comando abaixo, que irá garantir o acesso ao serviço através da porta local 8080. Caso esta porta já esteja em uso, ajustar o comando para uma porta que esteja disponível.

```
kubectl port-forward service/dvp6-netflix-product-details 8080:8083 -n dvp6-netflix-product-details
```

## TODO:

Automação geral desse processo e extensão aos demais serviços.