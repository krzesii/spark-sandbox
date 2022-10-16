ARG BASE_CONTAINER=jupyter/pyspark-notebook
FROM $BASE_CONTAINER

USER root

# RSpark config
ENV R_LIBS_USER "${SPARK_HOME}/R/lib"
RUN fix-permissions "${R_LIBS_USER}"


# R pre-requisites
RUN apt-get update --yes && \
    apt-get install --yes --no-install-recommends \
    fonts-dejavu \
    gfortran \
    netcat \
    gcc && \
    apt-get clean && rm -rf /var/lib/apt/lists/*


# R packages including IRKernel which gets installed globally.
RUN mamba install --quiet --yes \
    'r-base=4.1.0' \
    'r-ggplot2=3.3*' \
    'r-irkernel=1.2*' \
    'r-rcurl=1.98*' \
    'r-sparklyr=1.7*' && \
    mamba clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

# Spylon-kernel
RUN mamba install --quiet --yes 'spylon-kernel=0.4*' && \
    mamba clean --all -f -y && \
    python -m spylon_kernel install --sys-prefix && \
    rm -rf "/home/${NB_USER}/.local" && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"


COPY notebooks/*.ipynb "/home/${NB_USER}"

RUN mkdir -p "/home/${NB_USER}/resources"
COPY resources/*.* "/home/${NB_USER}/resources/"
COPY notebooks/ "/home/${NB_USER}/notebooks/"
COPY exercises/ "/home/${NB_USER}/exercises/"

RUN chown -R ${NB_USER} "/home/${NB_USER}/notebooks/"
RUN chmod 755 "/home/${NB_USER}/notebooks/"

RUN chown -R ${NB_USER} "/home/${NB_USER}/exercises/"
RUN chmod 755 "/home/${NB_USER}/exercises/"

USER ${NB_UID}