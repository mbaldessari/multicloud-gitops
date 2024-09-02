# golang-external-secret chart

This chart configures the External Secret Operator.
It assumes that a subscription for ESO has been defined in one of the values
files:

    clusterGroup:
      namespaces:
        - golang-external-secrets
      subscriptions:
        eso:
          channel: alpha
          name: external-secrets-operator
          namespace: golang-external-secrets
          source: community-operators

It adds a ClusterSecretStore backend in case vault is being used
and makes sure that the `golang-external-secret` service account
has the proper rights and the proper token to authenticate against
the vault (when used).
