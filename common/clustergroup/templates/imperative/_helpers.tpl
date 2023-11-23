# Pseudo-code
# 1. Get the pattern's CR
# 2. If there is a secret called vp-private-repo-credentials in the current namespace, fetch it
# 3. If it is an http secret, generate the correct URL
# 4. If it is an ssh secret, create the private ssh key and make sure the git clone works

{{/* git-init InitContainer */}}
{{- define "imperative.initcontainers.gitinit" }}
- name: git-init
  image: {{ $.Values.clusterGroup.imperative.image }}
  imagePullPolicy: {{ $.Values.clusterGroup.imperative.imagePullPolicy }}
  env:
    - name: HOME
      value: /git/home
  command:
  - 'sh'
  - '-c'
  - "mkdir /git/{repo,home};git clone --single-branch --branch {{ $.Values.global.targetRevision }} --depth 1 -- {{ $.Values.global.repoURL }} /git/repo;chmod 0770 /git/{repo,home}"
  volumeMounts:
  - name: git
    mountPath: "/git"
  - name: git-secret
    mountPath: "/git-secret"
{{- end }}

{{/* Final done container */}}
{{- define "imperative.containers.done" }}
- name: "done"
  image: {{ $.Values.clusterGroup.imperative.image }}
  imagePullPolicy: {{ $.Values.clusterGroup.imperative.imagePullPolicy }}
  command:
    - 'sh'
    - '-c'
    - 'echo'
    - 'done'
    - '\n'
{{- end }}

{{/* volume-mounts for all containers */}}
{{- define "imperative.volumemounts" }}
- name: git
  mountPath: "/git"
- name: values-volume
  mountPath: /values/values.yaml
  subPath: values.yaml
{{- end }}
