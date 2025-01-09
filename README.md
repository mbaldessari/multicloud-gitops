# Multicloud Gitops

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

[Live build status](https://validatedpatterns.io/ci/?pattern=mcgitops)

## Start Here

If you've followed a link to this repository, but are not really sure what it contains
or how to use it, head over to [Multicloud GitOps](https://validatedpatterns.io/patterns/multicloud-gitops/)
for additional context and installation instructions

## Rationale

The goal for this pattern is to:

* Use a GitOps approach to manage hybrid and multi-cloud deployments across both public and private clouds.
* Enable cross-cluster governance and application lifecycle management.
* Securely manage secrets across the deployment.


## Deployment

The steps are the next:

* Copy the secrets:

    ```bash
    cp values-secret.yaml.template ~/.config/hybrid-cloud-patterns/values-secret-multicloud-gitops.yaml
    ```

* Install the pattern:

    ```bash
    ./pattern.sh make install
    ```

* If secrets are added/modified after installation then:

    ```bash
    cp values-secret.yaml.template ~/.config/hybrid-cloud-patterns/values-secret-multicloud-gitops.yaml
    ./pattern.sh make load-secrets
    ```

* Create a secret for RHDH and added to the values-secret.yaml.template and
  reload it

  ```bash
  $ oc -n developerhub-ns create token default

  # Copy output to values-secret.yaml.template
  # Also update the other values accordingly, you can get ARGOCD_PASSWORD from hub-gitops-cluster secret at namespace multicloud-gitops-hub
  $ cat values-secret.yaml.template
    - name: rhdh-keys
      fields:
      - name: BACKEND_SECRET
        value: rhdh_1_2_3
      - name: GH_ACCESS_TOKEN
        value: XXXX
      - name: GH_CLIENT_ID
        value: XXX
      - name: GH_CLIENT_SECRET
        value: XXX
      - name: ARGOCD_USERNAME
        value: admin
      - name: ARGOCD_PASSWORD
        value: XXX
      - name: RHDH_TEKTON_SERVICE_ACCOUNT_TOKEN
        value: XXXX

  # Regenerate the vault with the secrets
    cp values-secret.yaml.template ~/.config/hybrid-cloud-patterns/values-secret-multicloud-gitops.yaml
    ./pattern.sh make load-secrets
  ```

* If your admin user do not have access to the Cluster ArgoCD, then ensure that
  the ArgoCD object have `default_policy: role:admin`, or configure the specific
  group policies as needed:

    ```bash
    oc -n openshift-gitops edit argocd  openshift-gitops
    ```


* At the Red Hat Developerhub, click on the Create, register an existing
  component and use the next url:

    ```
    #https://github.com/redhat-ai-dev/ai-lab-template/blob/main/all.yaml
    https://github.com/redhat-ai-dev/ai-lab-template/blob/release-v0.9.x/all.yaml
    https://github.com/redhat-ai-dev/model-catalog-example/blob/v0.1/ollama-model-service/catalog-info.yaml
    https://github.com/redhat-ai-dev/model-catalog-example/blob/v0.1/developer-model-service/catalog-info.yaml
    ```
