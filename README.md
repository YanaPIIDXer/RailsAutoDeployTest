# リポジトリ概要
RailsアプリケーションのCI/CDパイプライン実験リポジトリ。  
ステップ毎にブランチを切って実験を進める。  
※初回の動作検証を除き、CI/CDパイプラインはmainブランチへのマージをトリガーにする予定。  
- Nginx/Puma/Rails/MySQLの構成
- Docker使用
  - ローカル環境ではdocker-composeも
- デプロイにCapistrano使用
- CI/CDパイプラインはGithub Actionsで構築
  - 選定理由は使用経験がないので知見が欲しい事と、CircleCIは「特定のブランチにマージされた時のみ実行」の記述が面倒だった気がする事
- AWSを本番環境のインフラとする
  - EC2 → ECR/ECSの順に実験
- Terraformは検討中
  - 細かい構成がブラックボックスにならないよう、最終的にはコード化した方がベターだろうか？