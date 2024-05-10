# 落単回避

「落単回避」という、欠席回数をカウントして、あと何回で落単になってしまうかが、一目でわかる。アプリです！
授業を何回欠席したか覚えてないことや、あと何回休めるのかを知りたいなどの経験はありますか。
落単回避では、授業の欠席回数を入力してあと何回休めるのかを表示して瞬時にわかるようになります！
このアプリ一つで、あなたの学生生活を豊かなものになります！

## 環境
- Xcode15
- iOS17
- Android Studio 2022.3.1 Patch 1
- Flutter 3.19.5
-  Dart 3.3.3 
## 使用技術
- Dart
- Flutter
- sqflite
- git
- github
- drift
- Riverpod

## 技術選定理由
- drift→  
データの複雑さ: 複数のテーブルとそれらの間のリレーショナルな関係を設定し、効率的にクエリを実行できるデータの整合性を保つためのトランザクション処理や外部キー制約などのデータベース機能を利用できる。
これにより、多くの異なる属性や関連するエンティティ（例えば、授業名、教室など）を持つアプリケーションのニーズに応えることができるから。

データ量: SQLiteは非常に軽量でありながら、大量のデータ操作とストレージを効率的に扱うことが可能。
インデックス作成、クエリ最適化などの機能により、大規模なデータセットの検索と更新が高速に行える。

開発環境: Dart/Flutterとの完全な統合により、開発プロセスが簡素化され、一貫したコーディング体験が得られる。
アプリケーションの要件: リアルタイムのデータ更新と同期をサポートし、データベースの変更が即座にUIに反映される。複雑なクエリやデータ変換を効率的に処理し、アプリケーションのパフォーマンスを向上させる。

授業の時間割を管理するアプリであるため、授業名、授業の詳細、場所、欠席回数、遅刻回数などの複数の属性を持つデータを扱うためリレーショナルデータベースの利用をしました。
＜不採用理由＞
SharedPreferences: SharedPreferencesは小規模なデータや単純なキーバリューデータの保存に適しており、複雑なリレーショナルデータの管理には向いていないため不採用
firebase：アプリとしてリリースすると課金制などの課題があった。このアプリは個人の授業情報をユーザーの端末ごとに保存するだけで良いので、代わりにローカルでデータ管理ができるものを選びました。


## 製作期間
実装時間は、１ヶ月ほどです。
## アプリの特徴
- 自分の欠席回数と出席回数が一目でわかります！
- 自分の時間割もアプリを開くだけで一目でわかります！
- シンプルなUIなので、使いやすいです！
- 欠席回数が上限に達すると、「落単」という文字が表示されます。
- 欠席回数をボタンひとつで管理できます！



## 工夫した点
- 授業名と欠席回数を一目でわかるようなUIにしました。
- 楽しんでもらうために、欠席回数と表示するのではなく、残りライフとして❤️を表示するようにしました。
- 欠席回数が上限に達すると、「落単」という文字が表示されるようにしました。
- 欠席回数の入力を簡単にするために、ボタン式にしました。
 ## 課題
- クォーター性の授業対応
- 実験などの一度でも落としてしまう例外への対応
- もう少し、授業への情報を入力する欄を作成すること
- 広告をつける


## デモ動画
 
https://github.com/hashimo000/schedule_app/assets/103234756/2488b7bd-3de2-49d3-b78d-ffdf01fdbd11


## App Store にアプリをリリースしました！URLをクリックしてダウンロードしてください！
https://apps.apple.com/jp/app/%E8%90%BD%E5%8D%98%E5%9B%9E%E9%81%BF/id6497333664

## Google Playにアプリをリリース！URLをクリックしてダウンロードしてください！
https://play.google.com/store/apps/details?id=com.hashimoto.schedule