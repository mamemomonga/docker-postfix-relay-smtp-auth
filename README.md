# SMTP-AUTH 専用 リレー用メールサーバ

これは、SMTP-AUTH専用に設定したSMTPサーバ(postfix)です。

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

# 参考情報

送信側のpostfixの設定例

	$ vim /etc/postfix/main.cf
	...
	relayhost = [example.com]:2525
	smtp_sasl_auth_enable  = yes
	smtp_sasl_password_maps = hash:/etc/postfix/smtp-auth-passwd
	smtp_sasl_security_options = noanonymous
	smtp_sasl_mechanism_filter = cram-md5, plain, login

	$ vim /etc/postfix/smtp-auth-passwd
	[example.com]:2525 user1:password1

	$ postmap /etc/postfix/smtp-auth-passwd
	
	$ service postfix restart

	$ tail -f /var/log/mail.log

# License

	MIT

