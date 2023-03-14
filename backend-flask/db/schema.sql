CREATE EXTENSION "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
export CONNECTION_URL="postgresql://postgres:password@127.0.0.1:5432/cruddur"
gp env CONNECTION_URL="postgresql://postgres:password@127.0.0.1:5432/cruddur"

export PROD_CONNECTION_URL="postgresql://root:Larydb1#@cruddur-db-instance.cjpqwudpceov.us-east-1.rds.amazonaws.com/cruddur"
gp env PROD_CONNECTION_URL="postgresql://root:Larydb1#@cruddur-db-instance.cjpqwudpceov.us-east-1.rds.amazonaws.com/cruddur"