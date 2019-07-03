## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| application | Application tag | string | n/a | yes |
| delay\_termination |  | string | `"0"` | no |
| env\_vars |  | map | n/a | yes |
| group\_names | Settings | list | n/a | yes |
| lambda |  | map | n/a | yes |
| name | Name tag | string | n/a | yes |
| policy |  | string | `""` | no |
| provisionersrc | Tag linking to the repository | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| iam-role |  |
