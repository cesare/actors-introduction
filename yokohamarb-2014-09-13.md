# Actors Introduction

* 2014.09.13 yokohama.rb
* @cesare a.k.a SAWADA Tadashi

---

## 自己紹介

* 沢田正
* github: @cesare
* facebook.com/sawada.tadashi
* Tokyu.rb
* (いろいろあって) 目下フリーランス

---

## yokohama.rb

* 最初の1,2回に参加
* たぶん4年ぶり？
* お久しぶりです

---

# ところで

___

# 9/13

___

## プログラマの日

* 1/1から数えて256日目
* ロシアの休日 (らしい)


___

## 閑話休題


---

## 宣伝

* TokyuRubyKaigi
* 11/29 (土)
* bit.ly/tqrk08
* LTer 募集中
* 今回はサントリーさん来ません

---

## 本日のお品書き

* actor 概要
* Elixir の紹介
* goroutine との比較
* Celluloid の紹介
* 分散 actors
* link, supervise
* 応用例
* 参考文献

---

* 並行・並列とか、あまり触れません
* actor ってどんな感じ？を中心に
* ゆるふわ路線 :)

---

## actor 概要

* 並行計算モデルの一つ
* リソースを共有しない
* 内部状態の隠蔽
* メッセージを用いた対話

* OOP で言うところのオブジェクトと似ている
  * 内部状態の隠蔽
  * メッセージを用いた対話

___

## メッセージ送信

foo にメッセージ bar を送る

### OOP 的

```ruby
# ruby の例
answer = foo.bar
answer = foo.send :bar
```

```objective-c
// Objective-C の場合
answer = [foo bar];
```

### Actor 的

```
# Elixir
send(foo, :bar)
```

```scala
// Akka
foo ! bar
```
---

## メッセージ送信

* 非同期
* mailbox

---

## 具体例

* Elixir
  * ErlangVM 上で動く
  * Ruby によく似た構文
  * 軽量プロセス = actor
* デモ
  * actor を起動する
  * メッセージを送る
  * メッセージを受け取る
  * actor を起動して、計算結果を受け取る

___

## Elixir

```elixir
# actor を起動する
foo = spawn(Foo, :loop, [])

# メッセージを送る
send(foo, {:bar, "Hello"})

# 返事を待つ
receive do
  {:ok, answer} -> IO.puts(answer)
  {:ng, error}  -> IO.puts(error)
end

```

---

## mailbox

* メール配信的なメッセージ送受信
* 簡易メッセージキュー
* 非同期
* 返事はメールボックスに返す

---

## mailbox 具体例

* Celluloid
  * Ruby での actor 実装
  * mailbox が明示的
* デモ
  * 普通のオブジェクト的な振舞い
  * future
  * 非同期
  * mailbox

---

## goroutine との違い

* channel vs mailbox
  * channel : 送受信の両側で共有
  * mailbox : 受信側が持つ
* デモ

---

## link, supervise

* 親 actor spawn -> 子 actor
* spawn した子が死んだ
  * 何もしないと気づかない
* 子の状態を監視
  * 突然の死に備える

---

## link, supervise

* 親
  * worker にタスクを任せる
  * 結果 or 失敗を待つ
  * しくじったらどうするか考える
    * 諦める
    * 再挑戦
    * パラメータを変えて再挑戦
* 子
  * 最低限のタスクに徹する
  * 例外処理とかがんばらない
  * 突然の死でok

---

## 分散 actors

* ネットワーク越しの対話
* アドレス
* デモ
  * Elixir の node 間通信

___

## 分散 actors with Elixir

```bash
# 1つめのプロセスを名前 'foo' で起動
$ iex --sname foo

# 2つめのプロセスを名前 'bar' で起動
$ iex --sname bar
```

```elixir
# Node foo から bar へ接続
Node.connect :"bar@localhost"

# 接続中の node
Node.list  # => [:"bar@localhost"]

# bar から見ると
Node.list  # => [:"foo@localhost"]
```

---

## 応用例

* Adhearsion
  * VoIP のミドルウエア
  * Asterisk の制御用
  * Celluloid
  * UDP による通話制御
  * 非同期なイベントに反応

---

## 使いどころ

* event stream 的な処理
  * チャット
  * Twitter user streams
  * pubsub 的なやつ
  * WebSocket
  * WebRTC
  * サーバー監視系、定期ポーリング
  * etc

---

## Actor 実装

* Elixir / Erlang
* Celluloid, DCell
* Akka

---

## 参考文献

* Programming Elixir (pragprog)
* Seven Concurrency Models in Seven Weeks (pragprog)
* Principles of Reactive Programming (coursera)

---

# おまけ

---

## 並列と平行

* 並列 = parallel
* 並行 = concurrent

---

## 超訳・並列＆並行

* 横並び用意ドンで走り始めるのが並列
  * 巨大な行列計算とか
* 譲り合いつつ一緒に走るのが平行
  * イベントドリブン的なアレ
  * node.js

---

## 参考文献

* Parallel and Concurrent Programming in Haskell (O'Reilly)

```haskell
-- 通常
(fib 35, fib 36)

-- 並列
(fib 35, fib 36) `using` parPair
```
