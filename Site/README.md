
---

# 🛠️ Instruções de Configuração e Implantação do Aplicativo ASP.NET Core em ECS Fargate na AWS via Terraform

Este guia oferece um passo a passo completo para configurar e implantar um aplicativo **ASP.NET Core** em um ambiente **ECS Fargate** na AWS, usando **CI/CD com CodePipeline, CodeBuild e CodeDeploy**.

---

## ✅ Pré-requisitos

* Conta AWS com permissões suficientes
* Git instalado localmente
* Docker instalado localmente
* Conhecimentos básicos de:
  * Docker
  * ASP.NET Core
  * AWS CLI / Console

---

## 📁 1. Configuração do Projeto

### Passo 1: Clonar o repositório

Criar um repositório no Github e clonar para seu disco local.
```bash
git clone https://github.com/seu-usuario/seu-repositorio.git
cd seu-repositorio
```

### Passo 2: Verificar o Dockerfile

Certifique-se de que há um `Dockerfile` com base no ASP.NET Core:

```Dockerfile
# Etapa de build
FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build
WORKDIR /src

# Copiar o projeto e restaurar as dependências
COPY *.csproj ./
RUN dotnet restore

# Copiar todo o código e compilar
COPY . ./
RUN dotnet publish -c Release -o /app/publish

# Etapa de runtime
FROM mcr.microsoft.com/dotnet/core/aspnet:3.1 AS runtime
WORKDIR /app
COPY --from=build /app/publish .

# Porta padrão ASP.NET Core
EXPOSE 80

# Substitua "MeuSite.dll" pelo nome correto do seu projeto
ENTRYPOINT ["dotnet", "MeuSite.dll"]
```

> **Nota:** O build no Dockerfile pode ser útil localmente, mas o build *oficial* será feito pelo **CodeBuild**.

---
### Passo 3: Testar localmente:

1. **Build da imagem Docker:**

```bash
docker build -t aspnet-core-app .
```

2. **Executar o container:**

```bash
docker run -d -p 8080:80 --name aspnetcore aspnet-core-app
```

3. **Acessar no navegador:**

```
http://localhost:8080

```
---

### Passo 4: Adicionar um `.dockerignore` para acelerar o build:

```dockerignore
bin/
obj/
*.md
*.user
*.suo
.vscode/
.git/
```
---

## ☁️ 2. Configuração da AWS

### 2.1 Criar Cluster ECS Fargate

1. Acesse o console ECS > Clusters > **Criar cluster**
2. Selecione **"Fargate"**
3. Defina:

   * Nome: `aspnet-core-cluster`
   * VPC: Crie ou use uma existente
   * Sub-redes públicas ou privadas (dependendo do acesso necessário)
   * **Enable Container Insights (opcional):** marque se quiser monitorar CPU/RAM via CloudWatch
4. Clique em **Create**
   
### 2.2 Criar um Application Load Balancer (ALB)

1. Acesse EC2 > Load Balancers > **Criar Load Balancer**
2. Tipo: **Application Load Balancer**
3. Clique em **"Criar"*
4. Configure:
   * Nome do load balancer:
   * Esquema: Voltado para a Internet
   * Tipo de endereço IP do balanceador de carga: IPv4
   * VPC: selecione a vpc
   * Zonas de disponibilidade e sub-redes: Pelo menos 2 zonas de disponibilidade
   * Grupo de segurança: selecione 
   * Listeners: Porta 80
   * Grupos-alvo: Novo grupo para ECS (HTTP, porta 80)
5. Criar Load Balancer
6. Copie o **ARN** do grupo-alvo e o **DNS** do Load Balancer

---

## 🔁 3. Configuração do CI/CD (Pipeline)

### 3.1 Criar Bucket S3 (opcional)

Use para armazenar artefatos de build:

```bash
aws s3 mb s3://aspnet-core-deploy-artifacts
```

### 3.2 Criar Projeto CodeBuild

1. Acesse o **AWS CodeBuild**
2. Crie um projeto chamado `aspnet-core-build`
3. Fonte: GitHub ou CodeCommit
4. Ambiente:

   * SO: Ubuntu
   * Runtime: Standard (Node.js, .NET, etc.)
   * Image: `aws/codebuild/standard:6.0`
5. `buildspec.yml`:

```yaml
version: 0.2

phases:
  install:
    runtime-versions:
      dotnet: 6.0
  build:
    commands:
      - echo "Iniciando build..."
      - dotnet publish -c Release -o output
artifacts:
  files:
    - '**/*'
  base-directory: output
```

> **Dica**: Configure permissões IAM para permitir acesso ao ECS e S3.

---

### 3.3 Criar App no ECS (Task Definition)

1. ECS > Task Definitions > Criar nova
2. Tipo: **Fargate**
3. Adicione container:

   * Nome: `aspnet-core-app`
   * Imagem: use o URI do repositório ECR (será usado depois)
   * Porta: 80
4. Salve a task definition

---

### 3.4 Criar Serviço ECS

1. ECS > Cluster > Selecione o cluster
2. Criar Serviço:

   * Tipo: Fargate
   * Task Definition: escolhida acima
   * Load Balancer: selecione o existente
   * Sub-redes e segurança: permita acesso HTTP

---

### 3.5 Criar Pipeline CodePipeline

1. Acesse **AWS CodePipeline**
2. Crie pipeline:

   * Fonte: GitHub ou CodeCommit
   * Build: selecione o projeto do CodeBuild
   * Deploy: Use **AWS ECS (Blue/Green ou Rolling Update)**

     * Escolha o Cluster, Serviço e Target Group
3. Finalize e salve.

---

## ▶️ 4. Execução

### Passo Final: Rodar Pipeline

* Faça um **push** no seu repositório
* O **CodePipeline** será acionado automaticamente
* O **CodeBuild** fará o build
* O **CodeDeploy** atualizará o serviço ECS
* O **ALB** estará servindo o tráfego para os novos containers

---

## 📊 5. Monitoramento com CloudWatch

Configure:

* Logs do container via AWS Logs
* Alarmes de CPU e memória via CloudWatch
* Dashboards e alertas por e-mail (SNS)

---

Se quiser, posso gerar um **diagrama visual da arquitetura**, um **template Terraform** ou um exemplo de **buildspec.yml + taskdef.json completo** para facilitar. Deseja algum desses itens?
