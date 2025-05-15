
---

## ✅ Estrutura básica Terraform modularizado

```
infra/
├── main.tf                      # Chamada de todos os módulos
├── variables.tf                 # Declaração das variáveis globais
├── outputs.tf                   # Saídas globais
├── provider.tf                  # Provider + backend (se houver)
├── terraform.tfvars             # Valores das variáveis
├── modules/
│   ├── alb/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── codebuild/  
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── codepipeline/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── ecs_service/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── ecs_task_definition/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── fargate/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── iam_roles/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── networking/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── routes/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── s3_artifacts/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── security_groups/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── vpn/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf

```