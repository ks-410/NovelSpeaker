# リリース時に使ういろんなメモ。

# アイコン

http://www.flaticon.com/

# アプリの名前

* 日本語
ことせかい: 小説家になろう読み上げアプリ

* 英語
NovelSpeaker: "Let's become a novelist" reading aloud application

# アプリの説明

小説家になろう で公開されている小説を読み上げるアプリです。
歩いている時や家事をしている時などに小説を "聞く" ことができます。
バックグラウンド再生に対応していますので、iPhone で他の作業をしながらでも小説を聞き続ける事ができます。

「ことせかい」という名前は、小説家になろうの小説を iPhone の読み上げさせてみたときに、
「異世界」を「ことせかい」と発音したことから来ています。
ということで、残念ながら現在アプリから使える読み上げ機能では異世界のような単語を間違えて読むことが案外多いです。
そのような場合を少しでも軽減させるために読み替えの機能もつけてありますが、あまり期待しないでください。(´・ω・`)

使い方：
「なろう検索」で小説家になろうのサイトから読みたい小説を検索して、右上のdownloadボタンでダウンロードを開始させます。
ダウンロード中のものも「本棚」に登録されますので、ダウンロードの終わったものを選択して、右上の「Speak」を選択することで読み上げを開始します。

読み上げ開始位置を指定したい場合は、一旦読み上げを停止させて、読み上げを開始させたい位置を長押しして選択状態にしてから「Speak」ボタンを押す事で指定できます。
読み上げ位置は小説ごとに保存されます。


設定項目について

読み上げ速度などの変更方法：
「設定」タブの「声質の設定」から通常時の読み上げ設定(声質と速度)、会話文の時の設定(声質のみ)が、
「読みの修正」から「異世界」を「ことせかい」と読み上げさせないための設定ができます。
ただ、「読みの修正」に大量に修正項目を設定すると読み上げ開始時に結構かなりいっぱい待たされるようになります。すみません。

表示文字の大きさ：
「設定」タブの「表示文字サイズの設定」から、小説本文の表示に使われる文字の大きさを指定できます。

読み上げ時の間の設定：
「設定」タブの「読上げ時の間の設定」から、句読点や三点リーダーなどといったものについて、読み上げ時に間を開ける設定が可能です。

再生の自動停止：
「設定」タブの「最大連続再生時間」の項目で、再生を開始した後に自動的に停止するまでの時間を設定できます。標準では23時間55分になっていますので、概ね停止せずに読み上げがなされるように見えるはずです。

注意：
バックグラウンドで再生を行っている場合、画面が消えていたとしてもバッテリーの消費が増えますのでご注意ください。

小説のダウンロードが失敗してしまった場合：
小説家になろうのサイトが高負荷になっていたり、Web認証の必要なWiFi接続を行っている時などに小説をダウンロードした場合、小説ではない文字列が読み込まれることがあります。その場合は、ホームボタン二度押しで出てくるマルチタスク画面にて ことせかい を終了させて、再度起動の後、本棚メニューの右上にある矢印が回転しているボタンを押して再読み込みをさせてください。しばらく待つと再読み込みが読み込みが終わり、その後であれば正しい小説が読み込めているはずです。

高度な使い方：
* URLスキームによる小説のダウンロード
URLスキーム novelspeaker://downloadncode/ncode-ncode-ncode... という形式で ncode を指定することで、対象の小説をダウンロードキューに追加する事ができます。ncode とは、小説家になろうでの個々の小説のIDで、小説のページのURL(例えば http://ncode.syosetu.com/n0537ci/)の最後の部分(この例の場合は n0537ci)です。URLスキームでは ncode-ncode-ncode... と、複数の ncode を - (ハイフン) を使って繋げて記述できます。パソコン等で読んでいる小説を ことせかい でも読もうと思った時にこのURLスキームをiPhoneに送信して開くことでダウンロードを楽にできるようになる…… かもしれません。(単にアプリ内で検索してもいいような気がしますが)
なお、「設定」タブの「再ダウンロード用URLの取得」を用いることで、本棚に登録されている小説についてのダウンロードリストを取得することができます。機種変更をする時などにご利用ください。

* 自作小説の登録
設定タブの下の方の「新規自作小説の追加」を選択することで、自分で書いた文章を小説としてことせかいに登録することができます。
ここで作成した自作小説を再度編集したい場合、自作小説を表示している時に編集ボタン(小説家になろうの小説の場合は「詳細」ボタンがあった位置にあります)を押すことで再度編集できます。
なお、この自作小説の登録機能は、ちょっと汚い形で組み込んでしまっているので、今後のアップデートでもう少し違った形(EPUB形式での取り込みとか)での実装に変更するかもしれません。その場合はもしかすると自作小説自体を新形式に移行出来ない可能性があります(できるだけ残そうと努力はするつもりですけれども)。もしそうなってしまった場合はご容赦お願いしつつ、自作小説は別途バックアップを取っておいていただきますようお願い致します。

小説のダウンロードが失敗してしまった場合：
小説家になろうのサイトが高負荷になっていたり、Web認証の必要なWiFi接続を行っている時などに小説をダウンロードした場合、小説ではない文字列が読み込まれることがあります。その場合は、ホームボタン二度押しで出てくるマルチタスク画面にて ことせかい を終了させて、再度起動の後、本棚メニューの右上にある矢印が回転しているボタンを押して再読み込みをさせてください。しばらく待つと再読み込みが読み込みが終わり、その後であれば正しい小説が読み込めているはずです。

起動時に落ちてしまう場合：
アップデート後、起動時に落ちてしまう場合には、誠に申し訳ありませんが一旦アプリを削除してから、もう一度インストールすることで起動するようになります。ただ、アンインストールしてしまうとダウンロードした小説や読み替え辞書などの情報が全て消えてしまいます。すみません。


「小説家になろう」は株式会社ヒナプロジェクト様の登録商標です。
本アプリは株式会社ヒナプロジェクト様が提供するものではありません。

* 英語
NovelSpeaker is application to read the shown novel which is "Let's become a novelist" aloud.
"listen" hears a novel when I do walking time and housework.
Because I cope with background reproduction, I can continue hearing a novel even when carrying out other activities with iPhone.


# キーワード

* 日本語
小説家になろう, 読み上げ, 小説, なろう

* 英語
Let's become a novelist, novel, reading aloud

# サポートURL

http://limura.github.io/NovelSpeaker



# github pages で Autogenerate したら出てきたのでメモ

### Welcome to GitHub Pages.
This automatic page generator is the easiest way to create beautiful pages for all of your projects. Author your page content here using GitHub Flavored Markdown, select a template crafted by a designer, and publish. After your page is generated, you can check out the new branch:

```
$ cd your_repo_root/repo_name
$ git fetch origin
$ git checkout gh-pages
```

If you're using the GitHub for Mac, simply sync your repository and you'll see the new branch.

### Designer Templates
We've crafted some handsome templates for you to use. Go ahead and continue to layouts to browse through them. You can easily go back to edit your page before publishing. After publishing your page, you can revisit the page generator and switch to another theme. Your Page content will be preserved if it remained markdown format.

### Rather Drive Stick?
If you prefer to not use the automatic generator, push a branch named `gh-pages` to your repository to create a page manually. In addition to supporting regular HTML content, GitHub Pages support Jekyll, a simple, blog aware static site generator written by our own Tom Preston-Werner. Jekyll makes it easy to create site-wide headers and footers without having to copy them across every page. It also offers intelligent blog support and other advanced templating features.

### Authors and Contributors
You can @mention a GitHub username to generate a link to their profile. The resulting `<a>` element will link to the contributor's GitHub Profile. For example: In 2007, Chris Wanstrath (@defunkt), PJ Hyett (@pjhyett), and Tom Preston-Werner (@mojombo) founded GitHub.

### Support or Contact
Having trouble with Pages? Check out the documentation at http://help.github.com/pages or contact support@github.com and we’ll help you sort it out.




# Ver 1.0.2 リリースノート

インタフェースの変更
・小説を読んでいる画面で前と後の章への移動用にボタンをつけました。左右フリックでの移動はできなくなります。

問題の修正
・リロードした最新のものがダウンロードできなかった問題を修正
・バックグラウンド再生中に章を移動した時、再生が停止する可能性があった問題を修正
・小説の表示がステータスバーやナビゲーションバーにかぶって表示されて見えなくなることがある問題を修正
・読み替えの設定を増やすと再生開始や章の切り替わり時に長時間無反応になる問題を"ある程度"修正。(件数が増えれば遅くはなります)
・大量の小説をダウンロードした状態だと動作が遅くなっていた問題を修正

# Version 1.0.2 release note

Change of the interface

- I attached a button for the front and the movement to a later chapter with the screen which read a novel. By the right and left flick cannot move now.

Correction of the problem

- I revise the problem that the latest thing which I reloaded was not able to download.
- When I moved a chapter during background reproduction, I revise the problem that reproduction might stop.
- I revise the problem that the indication of the novel is fogged in a status bar and navigation bar, and it may not seem that it is displayed.
- I revise a reproduction start and the problem that I am replaced, and nothing sometimes reacts to for a long time of the chapter when I increase the setting of the reading substitute. (if the number increases, it becomes late)
- Movement revises the problem that became slow if in condition to have downloaded a large quantity of novels.

# Ver 1.1 リリースノート

インタフェースの変更
・本棚、なろう検索、ダウンロード状態 のアイコンを変更しました。
・小説の表示用の文字サイズを変更できるようにしました。「設定」に項目が増えます。
・iPadでも表示できるようにしました(ユニバーサルアプリとなります)。
・読み上げ中に最後の章を読みきった時に、「読み上げが最後に達しました」とアナウンスするようになります。
・起動時に最後に読んでいた小説を表示するようになります。
・最大連続再生時間の指定を設定ページに入れました。標準では23時間55分になっています。再生を開始してから、ここで設定された時間が経つと再生が停止します。
・読み上げ時に「……」や「、」「。」等でも読み上げの間をつけられるような設定項目を設定ページに追加しました。
・小説の詳細ページの作者名を押すと、その作者の小説を検索するようになります。
・小説を読むページにシェアボタンを追加しました。今読んでいるページへのURLやことせかいのアプリへのリンクなどをTwitterやmailでシェアすることができます。
・URLスキーム novelspeaker://downloadncode/ncode-ncode-ncode... という形式で、ncode を指定して小説をダウンロードさせる事ができるようになります。「設定」タブの「再ダウンロード用URLの取得」で本棚に登録されている小説についてのダウンロード用URLを取得できますので、機種変更等の際にご利用ください。

追伸：
レビューありがとうございます。不都合の報告や機能追加などの提案、本当にありがたいです。

読みの修正用の読み替え辞書をサーバにアップロードしてユーザ間で共有する事についてなのですが、サーバの管理が発生する(24時間365日起動し続けているサーバを管理するのはちょっと大変な)のと(無いとは思いますが)意図しない読み替え(例えば「あ」を「くぁｗせｄｒｆｔｇｙふじこ」に読み替えるとか)を行う読み替え辞書の登録がなされた場合の排除方法といった、複数ユーザによる登録にまつわる問題を考えるのが大変そうだなぁ、と思ったのでとりあえず良い案が浮かぶまでは実装はしないことにしました。

読み上げ時の間の設定については、標準の方法ですととても短い「間」の指定が(おそらく)できません。今回のリリースでは非推奨の方式を選択することができるようにすることでいろいろな文字に対しても「間」の設定ができるようにしています。ただ、非推奨の方式は Siriさん の読み上げ方式の穴を突いているような所がありまして、将来的には意図した通りには使えなくなる可能性がありそうです(具体的には指定された間の長さに応じた回数「_。」という文字列を読み上げさせています)。ですので、非推奨型での間の設定の使用はあまりおすすめしないことにしておきます。ご了承ください。

Interface change
- Icon changed.
- Text size change configuration is now on settings page.
- iPad mode. NovelSpeaker is universal application now.
- If reached at the end of a book then announce messsage: "Because it reached at the end of a book, I stopped reading aloud."
- First open view is now "Last read page".
- "Max continuation reproduction time" configuration is now on settings page.
- "Speak wait config" configuration is now on settings page.
- Can search same writer novel, in novel details page.
- Share button added for novel read page.
- Custom URL scheme is now available. It can download with NCODE. Use novelspeaker://downloadncode/ncode-ncode-ncode...
  "ncode" is "Let's become a novelist"'s novel-code. "ncode" can found "Let's become a novelist" web page ( http://syosetu.com ). example ncode found at last of url  like http://ncode.syosetu.com/n9669bk/ (this example include ncode "n9669bk")

# Version 1.1.1

# TODO

- アップデートをダウンロードすると読み上げ位置(栞)が吹き飛んで一番最初になってしまう問題のfix

# リリースノート
インタフェースの変更
・読み上げの間の設定に 0.1刻み で変化させるボタンを追加しました。また、簡単な文を使っての読み上げテストができるようになります。
・小説の詳細ページの右上に、作者のマイページをSafariで表示するためのボタンを追加しました。
・なろう検索のタブで、検索時の順位付けを「総合評価の高い順」などから選べるようにしました。ただ、「検索開始」ボタンが画面外に押し出されてちょっと使いづらくなっています。すみません。

問題の修正
・読み上げの間の設定を「非推奨型」にした場合に文末の単語を2回読み上げる事がある問題を修正
・読み上げ対象の文字列に "@" が含まれている章を選択すると落ちる問題を修正
・読み上げ開始時に読み上げが失敗すると、アプリを落とさないと読み上げができなくなる問題を一部修正(再度再生させようとした時に読み上げられない問題を解決しただけで、読み上げが勝手に停止する問題については直せていません。すみません)

追伸：
評価やレビュー、ありがとうございます。回避方法がなく落ちてしまう不都合の報告がありましたので、主に不都合対応のリリースをさせていただきます。
その他、提案していただいた機能で、簡単に追加できそうなものについては追加してみました。ご確認ください。

本棚周り、コピー＆ペーストでの新規本の登録、他サイトの小説の読み込み等は実装するのに結構時間がかかりますので今回のリリースには含めることができませんでした。すみません。なお、これらの対応については結構かなりいっぱいたくさん時間がかかってしまいそうですので、気長に待っていただければ嬉しいです。



# Version 1.1.1 release note
Interface update
- "Speak wait config" page inploved.
- "Go to writer page" button added at novel detail page.

Bug fix
- Duplicate word speech about "Experimental" speak setting is fixed.
- I revise a problem to come off when I choose the chapter which "@" is included in for character string for the reading aloud.
- Speech start fail bug fixed.

# レビュー用メモ

修正項目以下の通りです。

Change of the interface

- I attached a button for the front and the movement to a later chapter with the screen which read a novel. By the right and left flick cannot move now.

Correction of the problem

- I revise the problem that the latest thing which I reloaded was not able to download.
- When I moved a chapter during background reproduction, I revise the problem that reproduction might stop.
- I revise the problem that the indication of the novel is fogged in a status bar and navigation bar, and it may not seem that it is displayed.
- I revise a reproduction start and the problem that I am replaced, and nothing sometimes reacts to for a long time of the chapter when I increase the setting of the reading substitute. (if the number increases, it becomes late)


# Ver 1.1.2

インタフェースの変更

・なろう検索のタブで、検索時の順位付けの部分を、タップしてから選択するタイプに変更しました。(検索開始ボタンがスクロールしないと見えない状態だったのを解消しました)
・設定タブに更新履歴の情報を追加しました。
・アプリの更新があった時に、一回だけダイアログを表示するようにしました。

追伸：
評価やレビュー、ありがとうございます。今回はほとんど更新はありません。
やはり、検索タブの所の PickerView(検索の順位付けのくるくる回るUI)が入ってしまって「検索開始」ボタンが見えなくなってしまっていて、スクロールしないと駄目になっていたのが原因(?)で検索出来ない人がおられるようでしたので、ちょっとUIを変えました。
あと、ことせかいをアップデートしたのが気づいてもらえないかもしれないなぁ、と思って、バージョン番号が変わった時には一回だけダイアログを出すようにしました。ということで、ちょっとウザくなってしまいます。すみません。

# Version 1.1.2

Interface change

- in Search tab, "Search order" is now show after tap.
- Add "Update log" in Settings tab.
- Update Notice dialog added. This is displayed first time only.


# Ver 1.1.3

問題の修正

・なろう検索のタブで、検索用文字列を入力できなくなっていた問題を修正しました。

追伸：
評価やレビュー、ありがとうございます。今回は検索が無意味になってしまうようなバグを入れたままリリースしてしまって申し訳ありませんでした。
焦って提出して安心したままじゃ駄目ですね…… 本当にすみませんでした。

# Version 1.1.3

Bug fix

- in Search tab, Search string is now can editable.


# Ver 1.1.4

インタフェースの変更

・文章上で長押しした時に出るメニューに、「読み替え辞書へ登録」を追加しました。コピーしてペーストする手間が少しだけ減ります。
・設定タブの下の方に「新規自作小説の追加」が増えます。自分で書いた文章を読み上げさせる時などにご利用ください。
作成した自作小説を再度編集したい場合、自作小説を表示している時に編集ボタン(小説家になろうの小説の場合は「詳細」ボタンがあった位置にあります)を押すことで再度編集できます。
なお、この自作小説の登録機能は、ちょっと汚い形で組み込んでしまったので、今後のアップデートでもう少し違った形での実装に変更するかもしれません。その場合はもしかすると自作小説自体を新形式に移行出来ない可能性があります(できるだけ残そうと努力はするつもりですけれども)。もしそうなってしまった場合はご容赦お願いしつつ、自作小説は別途バックアップを取っておいていただきますようお願い致します。

問題の修正

・読み上げが勝手に停止する問題を修正しました(多分これで根本的な対応になると思います)

追伸
評価やレビュー、ありがとうございます。長いことおまたせしてしまって申し訳ありません。自作小説の登録機能を追加してみました。自作小説だけでなく、小説家になろう以外の小説を読み上げさせることもできるようになったかと思います。ただ、小説家になろう以外からの小説を読み込ませる機能、と考えるとちょっと面倒臭いと思われるので、もう少し楽に登録できる方法(EPUBを読み込みとか)を考察中です。
それでは、今後とも ことせかい をよろしくお願い致します。


# Version 1.1.4

Interface change

- Add "Add default correction of the reading" menu on text long tap menu.
- Add "Add own created book" feature at Settings page. You can write yourself book now!

Bug fix.

- Reading aloud revises a problem to stop without permission.



# Ver 1.1.5

インタフェースの変更

・iOS 9 以上で、発音される音声データを選択できるようになります。設定タブの声質の設定に項目が増えます。
  利用可能な音声データは初期状態では一つだけですので、音声データを増やしたい場合は
  設定アプリ → 一般 → アクセシビリティ → スピーチ → 声 → 日本語
  と手繰っていった所で音声データをダウンロードしてください。
  (なお、Siriさんの音声データは O-ren(拡張) という名前になっているもののようです）
・Voice Over が有効になっている場合、読み上げ開始時に警告を発するようになります。
・本棚の並び順を変更できるようになります。本棚タブの右上にボタンが増えます。

問題の修正

・小説の更新分を読み込むなどをした時に、読み上げ位置が初期化される問題を修正
・電話がかかってきた時など、ことせかい 以外のアプリで音が使われる時に再生を停止しなかった問題を修正
・アプリ名が NovelSpeaker になっていたのを ことせかい になるように修正
・iPhone 6 Plus 等で上下に黒帯が入る事がある問題を修正
・内部DBへのアクセス時に落ちる問題を修正

追伸

評価やレビュー、ありがとうございます。かなり長いこと放置してしまっていてすみません。iOS 10 になって標準の音声データがしょぼくなりすぎたのを受けて、取り急ぎ標準の音声以外のデータを使えるようにしたものに更新致します。これで本物のSiriさんに読み上げてもらえるようになるはずです。ただ、これが出来るのに気づいたのが手元の端末を iOS 10 に上げた後でなので、iOS 9 では試しておらず、もしかすると利用できないかもしれません(なお、iOS 8 ではAppleの提供しているAPIに音声選択の項目が無いため利用できません)。もし、問題がありましたら恐れ入りますが最新の iOS へ更新するなどで対応していただけるとうれしいです。
なお、次回以降の更新時の話になりますが、ことせかい の対応OSバージョンを iOS 8 以上にすることを計画しています(現在は iOS 7 以上の対応です)。どうしても iOS 7 で動作して欲しいという方がおられましたら、サポートサイトの下の方に用意致しましたご意見ご要望フォームから思いの丈を送っていただけると対応できるようになるかもしれません。

# Version 1.1.5

Interface change

- Can select speaker data. You need download sepaker data from:
  Settings > General > Accessibility > Speech > Voices > Japanese
- If VoiceOver enabled, alert dialog is open when speak start.
- Bookshelf sort type selector now available.

Bug fix

- I read it aloud at the time of the re-reading of the novel, and a position revised an initialized problem.
- When it had a telephone, It come to stop reproduction.
- I revise the problem that a black belt holder may begin up and down in 6 iPhone Plus.
- Application revised a bug to be finished at the time of access to internal DB.


expedited app review に出した時の文言
---begin---
なろう検索のタブで、検索用文字列を入力できなくなっていた問題を修正しています。
この部分が入力できないと、検索で好みの小説を探すことができないため、あまり小説が選べないアプリになってしまっています。

問題の再現手順：

1. なろう検索 タブを開く
2. 一番上の「検索文字列」のテキストボックスを選択
3. 文字を入力する

3. のステップで、旧バージョンでは文字が入力できませんでした。

In English

In Search tab, Search string is now can editable.


The reproduction procedure of the problem:

1. Open the search tab
2. Choose the text box of a top "search string"
3. Input a letter

In 3. steppe, It was not able to input a letter in the old version.
----end----

# メモ

## ナビゲーションバー(上に出てくる「戻る」ボタンとかタイトルとかが表示される領域)に埋まる問題を解消するには、
インタフェースビルダの Adjust Scroll View Insets っていうチェックボックスを off にするといいっぽい。(理由理解してない)
http://qiita.com/yimajo/items/7c7372e284e13827c989

## iCloud で同期するには
CoreData を使う時の初期化に
NSPersistentStoreUbiquitousContentNameKey と NSPersistentStoreUbiquitousContentURLKey
というのを使うらしい？

Key-Value store とか Document Storage ってのでもできるっぽい。
http://blog.gentlesoft.net/article/56456255.html


http://d.hatena.ne.jp/glass-_-onion/20120728/1343471940

284話 たいがとの接触