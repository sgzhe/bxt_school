#JWTSessions.algorithm = 'HS256'
#JWTSessions.encryption_key = Rails.application.secrets.secret_jwt_encryption_key
JWTSessions.encryption_key = "secret"
JWTSessions.token_store = :memory
# JWTSessions.token_store = :redis, {
#     redis_host: "127.0.0.1",
#     redis_port: "6379",
#     redis_db_name: "0",
#     token_prefix: "jwt_"
# }