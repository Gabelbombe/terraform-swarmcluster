## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| ami-id |  | string | n/a | yes |
| application | Application tag | string | n/a | yes |
| discovery-bucket |  | string | n/a | yes |
| instance-type |  | string | n/a | yes |
| key-name |  | string | n/a | yes |
| name | Name tag | string | n/a | yes |
| provisionersrc | Tag linking to the repository | string | n/a | yes |
| security-group-ids |  | list | n/a | yes |
| size | Instance Settings | string | `"1"` | no |
| subnet-ids |  | list | n/a | yes |
| swarm-security-group-id |  | string | n/a | yes |
| volume\_size |  | string | `"52"` | no |
| vpc-id | Settings | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| autoscaling-group-name |  |
| instance-role-id |  |
