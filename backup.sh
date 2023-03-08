#!/bin/bash

# Definindo as variáveis
BACKUP_DIR="/mnt/backups"
BUCKET_NAME="seu-bucket"
AWS_REGION="sua-regiao"
DATABASE_USERNAME="seu-usuario"
DATABASE_PASSWORD="sua-senha"

# Obter a lista de todos os bancos de dados, exceto os bancos de sistema
DATABASE_LIST=`/opt/mssql-tools/bin/sqlcmd -S localhost -U $DATABASE_USERNAME -P $DATABASE_PASSWORD -Q "SELECT [name] FROM sys.databases WHERE [name] NOT IN ('master','model','msdb','tempdb')" -h-1`

# Loop para cada banco de dados
for DATABASE_NAME in $DATABASE_LIST
do
  # Definir o nome do arquivo de backup usando o nome do banco de dados e a data atual
  BACKUP_NAME="$DATABASE_NAME-$(date +'%Y-%m-%d').bak"

  # Executa o backup do SQL Server para o banco de dados atual
  /opt/mssql-tools/bin/sqlcmd -S localhost -U $DATABASE_USERNAME -P $DATABASE_PASSWORD -Q "BACKUP DATABASE [$DATABASE_NAME] TO DISK='$BACKUP_DIR/$BACKUP_NAME' WITH COPY_ONLY, NOFORMAT, NOINIT, NAME='$DATABASE_NAME-full', SKIP, NOUNLOAD, STATS=10"

  # Faz upload do backup para o bucket S3 na AWS
  aws s3 cp $BACKUP_DIR/$BACKUP_NAME s3://$BUCKET_NAME/$BACKUP_NAME --region $AWS_REGION

  # Remove o backup local após o upload para o S3
  rm $BACKUP_DIR/$BACKUP_NAME
done
