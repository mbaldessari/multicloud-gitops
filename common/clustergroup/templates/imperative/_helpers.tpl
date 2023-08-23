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
  - >-
    U="$(oc get secret -n openshift-gitops --selector 'argocd.argoproj.io/secret-type=repository' -o jsonpath='{.items[0].data.username}' | base64 -d)";
    P="$(oc get secret -n openshift-gitops --selector 'argocd.argoproj.io/secret-type=repository' -o jsonpath='{.items[0].data.password}' | base64 -d)";
    mkdir /git/{repo,home};
    URL=$(echo {{ $.Values.global.repoURL }} | sed -E "s/(https?:\/\/)/\1${U}:${P}@/");
    git clone --single-branch --branch {{ $.Values.global.targetRevision }} --depth 1 -- "${URL}" /git/repo;
    chmod 0770 /git/{repo,home}
  volumeMounts:
  - name: git
    mountPath: "/git"
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
