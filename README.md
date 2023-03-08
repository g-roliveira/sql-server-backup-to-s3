# Script de Backup do SQL Server para o AWS S3

Este script Bash é usado para fazer backup de todos os bancos de dados no SQL Server for Linux e enviá-los para um bucket no Amazon S3. O script executa backups completos diários para todos os bancos de dados do SQL Server, exceto os bancos de sistema.

## Pré-requisitos

    - SQL Server for Linux instalado e em execução
    - AWS CLI instalado e configurado com as credenciais adequadas
    - mssql-tools instalado no sistema de backup
    - Um bucket S3 existente para armazenar backups
    - Acesso de gravação ao diretório de backup local no sistema de backup


## Instalando aws-cli no Debian/Ubuntu

1. Atualizar a lista de pacotes
    ```bash
    sudo apt-get update

2. Instalar o pacote awscli
    ```bash
    sudo apt-get install awscli

3. Verificar se o aws-cli foi instalado com sucesso
    ```bash
    aws --version
    
## Instalando aws-cli no RHEL/CentOS

1. Atualizar a lista de pacotes
    ```bash
    sudo yum update

2. Instalar o pacote awscli
    ```bash
    sudo yum install awscli

3. Verificar se o aws-cli foi instalado com sucesso
    ```bash
    aws --version

*Obs: Lembre-se de configurar suas credenciais da AWS após a instalação do aws-cli para que você possa autenticar as solicitações ao S3. Você pode fazer isso executando o seguinte comando:*
```bash
aws configure
```
## Instalando mssql-tools. 

<a href="https://learn.microsoft.com/pt-br/sql/linux/sql-server-linux-setup-tools?view=sql-server-ver16&tabs=redhat-install%2Credhat-offline" target="_blank">Clique aqui</a> para acessar o guia de instalação das ferramentas do SQL Server no Linux da Microsoft.

## Como usar o Script

1. Clone este repositório em seu sistema de backup local:

   ```bash
   git clone https://github.com/seu-usuario/nome-do-repositorio.git

2. Edite o arquivo backup.sh e ajuste as variáveis no topo do arquivo de acordo com suas necessidades:

    - `BACKUP_DIR`: Diretório local onde os arquivos de backup serão armazenados temporariamente antes de serem enviados para o S3.
    - `BUCKET_NAME`: Nome do bucket do S3 da AWS para onde os arquivos de backup serão enviados.
    - `AWS_REGION`: Região do S3 da AWS onde o bucket está localizado.
    - `DATABASE_USERNAME`: Nome de usuário do SQL Server para conectar ao servidor.
    - `DATABASE_PASSWORD`: Senha do SQL Server para conectar ao servidor.

Salve as alterações no arquivo.

4. Torne o script executável:
    ```bash
    chmod +x backup.sh

5. Agende o script para ser executado diariamente, por exemplo, usando o cron no Linux. Adicione a seguinte linha ao arquivo cron para executar o script todos os dias às 3h da manhã:
    ```bash
    0 3 * * * /caminho/para/o/script.sh >/dev/null 2>&1
    
Certifique-se de substituir /caminho/para/o/script.sh pelo caminho para o arquivo backup.sh em seu sistema.


6. Execute o script manualmente para testar o backup:
    ```bash
    ./backup.sh

Isso irá executar o backup de todos os bancos de dados e enviar os arquivos de backup para o bucket S3.
