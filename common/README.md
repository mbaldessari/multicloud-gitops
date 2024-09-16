# Validated Patterns common/ repository

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

## Note

This is the `main` branch of common and it assumes that the pattern is fully
multisource (meaning that any used charts from VP is actually referenced from
either a helm chart repository or quay repository). I.e. there are no helm
charts contained in this branch of common.

## Start Here

This repository is never used as standalone. It is usually imported in each pattern as a subtree.
In order to import the common/ the very first time you can use
`https://github.com/validatedpatterns/multicloud-gitops/blob/main/common/scripts/make_common_subtree.sh`

In order to update your common subtree inside your pattern repository you can either use
`https://github.com/validatedpatterns/utilities/blob/main/scripts/update-common-everywhere.sh` or
do it manually by doing the following:

```sh
git remote add -f upstream-common https://github.com/validatedpatterns/common.git
git merge -s subtree -Xtheirs -Xsubtree=common upstream-common/main
```

## Secrets

There are two different secret formats parsed by the ansible bits. Both are documented [here](https://github.com/validatedpatterns/common/tree/main/ansible/roles/vault_utils/README.md)
