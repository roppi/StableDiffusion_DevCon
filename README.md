# StableDiffusion_DevCon
Windows + WSL2 + VSCode + Remote Containers + Stable Diffusion WebUI

ローカル環境でサクッと Stable Diffusion を動かすための設定など。
nvidiaのグラボがあることと、WSL2 + Docker Desktop + VSCode が利用できることが前提です。

## 事前準備

### 0. 前提環境のセットアップ（参考）

#### WSL2 のインストール
Windows 11 だと以下のコマンドと再起動
``` bash
wsl --install
```

#### Docker と VSCode のインストール
``` bash
winget install -h Microsoft.VisualStudioCode
winget install -h Docker.DockerDesktop
```
うまくいかない場合は、アプリの更新をしてみる（winget自体が古いことが原因だったりするので。。）

#### VSCode に RemoteContainers のインストール
``` bash
code --install-extension ms-vscode-remote.remote-containers
```

### 1. コンテナからGPUを使えるようにする
コンテナからGPUを使うために、各レイヤーに必要なソフトを入れる。

それぞれに必要なものと対処をまとめるとこんな感じ。

| レイヤー  | 必要なもの | 対処 |
| ------------- | ------------- | ------------- |
| Container  | cuda-toolkit  | インストール済みイメージを使用する |
| WSL + Docker  | nvidia-container-toolkit  | インストールする |
| Windows  | nvidia driver  | インストールする |

下から順に設定していく

#### Windows に nvidia driver のインストール
通常のグラフィックボードのドライバー更新を行う（GeforceExperienceから最新のドライバに更新など）

手動でのダウンロードは[ここ](https://www.nvidia.co.jp/Download/index.aspx?lang=jp)


#### WSL に nvidia-container-toolkit のインストール
WSLを起動して以下のコマンドを実行。

``` bash
# ダウンロード元のレポジトリを追加
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
  && curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
    sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
    sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list

# パッケージリストを更新
sudo apt-get update

# コンテナツールキットをインストール
sudo apt-get install -y nvidia-container-toolkit
```

**参考**
- https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html

#### cuda-toolkit 入りのイメージを取得して確認
以下のページから、使いたいOSとCUDAバージョンのイメージを確認する
- https://catalog.ngc.nvidia.com/orgs/nvidia/containers/cuda/tags


現時点で最新の Cuda 12.3.1 Ubuntu 22.04 の場合は `nvidia/cuda:12.3.1-base-ubuntu22.04` なので以下のコマンドを実行

``` bash
sudo docker run --rm --gpus all nvidia/cuda:12.3.1-base-ubuntu22.04 nvidia-smi
```

GPUの情報が表示されれば準備は完了です。

### 2. コンテナを起動する
