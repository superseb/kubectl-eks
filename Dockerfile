FROM alpine:latest

RUN apk add --update --no-cache bash curl py-pip && pip install awscli

RUN curl -o /usr/bin/kubectl https://amazon-eks.s3-us-west-2.amazonaws.com/1.10.3/2018-06-05/bin/linux/amd64/kubectl && \
    chmod +x /usr/bin/kubectl && \
    curl -o /usr/bin/heptio-authenticator-aws https://amazon-eks.s3-us-west-2.amazonaws.com/1.10.3/2018-06-05/bin/linux/amd64/heptio-authenticator-aws && \
    chmod +x /usr/bin/heptio-authenticator-aws

RUN mkdir -p /root/.kube

COPY kubectlconfig /root/.kube/config
COPY entrypoint.sh /usr/bin/entrypoint.sh

WORKDIR /root

ENTRYPOINT [ "/usr/bin/entrypoint.sh" ]
CMD [ "/bin/bash" ]
