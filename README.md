# SMTP-AUTH 専用 リレー用メールサーバ

これは、SMTP-AUTH専用に設定したSMTPサーバです。

ポート 2525 で公開します。TLSに対応しています。

# 要件

* Docker
* docker-compose

# 初期化

初期化を行うと、ディレクトリ作成と自己署名証明書のコピーが行われます。

すでに certs ディレクトリに証明書がある場合は上書きされますのでご注意ください。

	$ ./init.sh

# 設定

main.cf を編集し、myhostname にメールサーバのドメインを設定してください。

passwords ファイルをこのディレクトリに作成し、ユーザとパスワードを設定してください。以下のように複数設定可能です。

	USERNAME: user1 / PASSWORD: password1	
	USERNAME: user2 / PASSWORD: password2
	USERNAME: user3 / PASSWORD: password3

certs に 自己署名証明書がありますので、それを正しい証明書に置き換えてください。Let's Encrypt で取得した証明書が利用できます。(certs.sh参照)

# 起動と終了

	$ docker-compose up -d

# ログ

	$ tail -f log/syslog

# License

	MIT

