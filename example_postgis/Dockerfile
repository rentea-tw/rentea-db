FROM ubuntu:18.04

COPY setup_environment.sh /root/
COPY create_table.sh /root/
COPY demo_functions.sh /root/

RUN bash /root/setup_environment.sh
RUN bash /root/create_table.sh
RUN bash /root/demo_functions.sh