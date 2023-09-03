# Temp_mail_telegram_bot
Bot for creating temporary emails and receiving messages

.env.example
```
TOKEN = Enter the TOKEN of the telegram bot
USER_DB = user mysql
PASSWORD = password mysql
```

# Start

```
pip install -r requirements.txt
```
```
python main.py
```

# Docker build

```
docker build . -t temp-mail
```

```
docker run -d --network=host temp-mail
```