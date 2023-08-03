# Start from a core stack version
FROM jupyter/base-notebook:python-3.9


USER root

RUN apt-get update && apt-get install -y \
    g++ \
    libgdal-dev \
    && rm -rf /var/lib/apt/lists/*


# Set up environment variables to avoid asking for user input during installation
ENV NLTK_DATA=/usr/share/nltk_data


# Copy and install requirements
COPY --chown=${NB_UID}:${NB_GID} requirements.txt /tmp/
RUN pip install --quiet --no-cache-dir --requirement /tmp/requirements.txt && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

# Download the 'tokenizers' package using a Python script
RUN python -m nltk.downloader punkt
#RUN python -m nltk.downloader tokenizers

# Download nltk punkt
#RUN [ "python", "-c", "import nltk; nltk.download('punkt', download_dir='/usr/share/nltk_data');nltk.download('tokenizer', download_dir='/usr/share/nltk_data')" ]


