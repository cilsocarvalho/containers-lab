# Evidências — Lab-03

Capturas realizadas em 13 de outubro de 2026 no AWS Academy e Docker Hub. Para manter o histórico verificável, as imagens abaixo devem ser adicionadas a esta pasta, preservando os nomes indicados.

| Evidência | Arquivo | Verificação |
|---|---|---|
| Aplicação Flask acessível pelo DNS do Network Load Balancer | [01-aplicacao-nlb.png](01-aplicacao-nlb.png) | Página “Container Technologies” |
| Imagem disponível publicamente no Docker Hub | [02-dockerhub-publico.png](02-dockerhub-publico.png) | Repositório `famacil/ci-cd-app` |
| Serviço ECS em execução | [03-ecs-service-3-tasks.png](03-ecs-service-3-tasks.png) | `app-service` com 3/3 tasks running |
| Lista de tarefas do ECS | [04-ecs-tasks-running.png](04-ecs-tasks-running.png) | Três tasks RUNNING |
| Target Group do NLB | [05-target-group-healthy.png](05-target-group-healthy.png) | 3 Healthy, 0 Unhealthy |

## Pipelines GitHub Actions validadas

- [Lab03 - Infra — Success](https://github.com/cilsocarvalho/containers-lab/actions/runs/38495733230)
- [Lab03 - App — Success](https://github.com/cilsocarvalho/containers-lab/actions/runs/38496696777)

**Nota:** a coluna Health status = Unknown nas tasks não significa que o NLB falhou. Os três targets passaram o health check HTTP em `/health`. A aplicação usa HTTP na porta 80, conforme o exercício.

## Inclusão das imagens no GitHub

Na pasta `Lab-03/solution/evidencias`, use **Add file → Upload files** para enviar os cinco PNGs com os nomes acima. O GitHub não exibe diretamente um arquivo ZIP como galeria; descompacte o pacote antes do upload. Não inclua prints de credenciais AWS.
