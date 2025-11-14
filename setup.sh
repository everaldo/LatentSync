
#!/bin/bash
# Define uma flag para parar em caso de erro
set -e

# Cria um novo ambiente conda
echo "--- Creating conda environment 'latentsync' ---"
conda create -y -n latentsync python=3.10.13

# Ativa o ambiente para instalar pacotes dentro dele
echo "--- Installing packages into 'latentsync' ---"
conda run -n latentsync conda install -y -c conda-forge ffmpeg

# Instala as dependências Python com pip dentro do ambiente
# Certifique-se que requirements.txt existe!
conda run -n latentsync pip install -r requirements.txt

# Instala dependências do sistema com apt
echo "--- Installing system dependencies ---"
sudo apt-get update && sudo apt-get install -y libgl1

# Baixa os checkpoints
echo "--- Downloading checkpoints ---"
# O pip install acima já deve ter instalado huggingface-cli
conda run -n latentsync huggingface-cli download ByteDance/LatentSync-1.5 whisper/tiny.pt --local-dir checkpoints
conda run -n latentsync huggingface-cli download ByteDance/LatentSync-1.5 latentsync_unet.pt --local-dir checkpoints

echo "--- Setup complete! ---"
