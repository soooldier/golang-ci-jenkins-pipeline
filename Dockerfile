FROM csighub.tencentyun.com/cloud-energy/tlinux3.2:latest
ENV TZ Asia/Shanghai
RUN ln -fs /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone

ADD ./main.go ./

