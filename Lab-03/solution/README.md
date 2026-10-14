# Lab-03: implementação executável

Baseada no [roteiro da disciplina](../README.md).

## Arquitetura
GitHub Actions + Terraform com S3 State + VPC default existente + NLB TCP/80 + ECS Fargate com três tasks + Flask na porta 8000 + Docker Hub.

## Preparação
No repositório, configure Secrets (Settings > Secrets and variables > Actions):
- AWS_ACCESS_KEY_ID
- AWS_SECRET_ACCESS_KEY
- AWS_SESSION_TOKEN
- DOCKERHUB_USERNAME
- DOCKERHUB_TOKEN (access token Docker Hub)
Configure Variable: AWS_REGION=us-east-1.

Use credenciais **renovadas** do AWS Academy; não publique tokens no repositório. A sessão deve estar ativa. O laboratório usa a IAM role existente LabRole, VPC default e subnets públicas.

## Etapas de execução
1. Actions > Lab03 - Infra > Run workflow > apply. Aguarde a conclusão.
2. Actions > Lab03 - App > Run workflow > deploy. Aguarde testes, Trivy, push Docker Hub e deploy ECS.
3. Verifique 3 tasks RUNNING, target group healthy e aplicação em http://DNS-DO-NLB/.
4. Capture prints reais e anexe à pasta de evidências.

Para limpeza execute App destroy, depois Infra destroy; preserve o bucket S3 até finalizar o destroy.

## Execução local
```bash
cd Lab-03/solution/app
pip install -r requirements.txt
python -m unittest discover -v
docker compose up --build -d
curl -f http://localhost:8000/health
```

As credenciais configuradas apenas no Codespaces não são repassadas aos runners do GitHub Actions.
