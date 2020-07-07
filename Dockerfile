FROM continuumio/miniconda3

WORKDIR /app

# Create the environment:
COPY environment.yml .
RUN conda create -n myenv python=3.7
RUN conda install -c conda-forge boost-cpp gsl numpy cython blosc hdf5
RUN conda install variant_tools -c bioconda -c conda-forge

# Make RUN commands use the new environment:
SHELL ["conda", "run", "-n", "myenv", "/bin/bash", "-c"]

# Make sure the environment is activated:
RUN echo "Variant tools running"
RUN vtools

# The code to run when container is started:
ENTRYPOINT ["conda", "run", "-n", "myenv"]