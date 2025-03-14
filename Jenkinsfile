pipeline {
    agent any

    stages {
        stage('Prepare Environment') {
            steps {
                script {
                    // Загрузка переменных окружения из файла .env
                    def envVars = readProperties file: '/opt/env/.env.tempmail'

                    // Импорт переменных окружения в среду Jenkins job
                    envVars.each {
                        env."${it.key}" = "${it.value}"
                    }
                }
            }
        }
        stage('Get Old Image Tag') {
            steps {
                script {
                    // Получаем тег старого образа temp-mail
                    env.OLD_IMAGE_TAG = sh(script: "docker images temp-mail --format '{{.Tag}}' | head -n 1", returnStdout: true).trim()
                }
            }
        }
        stage('Build New Image') {
            steps {
                script {
                    // Создание уникального имени для нового образа
                    def timestamp = new Date().getTime()
                    env.NEW_IMAGE_NAME = "temp-mail:${timestamp}"

                    echo "# Собираем новый Docker образ"
                    sh "docker build -t ${env.NEW_IMAGE_NAME} ."
                }
            }
        }
        stage('Cleanup Old Container and Image') {
            steps {
                echo "# Принудительно останавливаем и удаляем старый контейнер, если он существует"
                sh "docker rm -f temp-mail || true"

                echo "# Удаляем старый Docker образ, если он существует"
                sh "docker rmi temp-mail:${env.OLD_IMAGE_TAG} || true"
            }
        }
        stage('Deploy New Container') {
            steps {
                echo "# Запускаем новый контейнер"
                sh "docker run -d --restart unless-stopped --name temp-mail -e TOKEN=$TOKEN -e USER_DB=$USER_DB -e PASSWORD=$PASSWORD ${env.NEW_IMAGE_NAME}"
            }
        }
    }
}
