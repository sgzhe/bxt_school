#JWTSessions.algorithm = 'HS256'
#JWTSessions.encryption_key = Rails.application.secrets.secret_jwt_encryption_key
JWTSessions.encryption_key = "secret"
#JWTSessions.token_store = :memory
if Rails.env == 'production'
 JWTSessions.token_store = :redis, {
     redis_host: ":bxt2020@10.200.2.249",
     redis_port: "6379",
     redis_db_name: "0",
     token_prefix: "jwt_"
 }
else
 JWTSessions.token_store = :memory
end
