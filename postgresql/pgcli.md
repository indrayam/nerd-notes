# PostgreSQL CLI tools

## psql

```bash
brew services start postgresql
# brew services stop postgresql
psql postgres
CREATE ROLE code WITH LOGIN PASSWORD 'password';
ALTER ROLE code CREATEDB;
\q
psql postgres -U code
```

pcli commands:
- `\l` or `\list` - List all databases in PostgreSQL
- `\c dbname` - Connect to a specific database
- `\?` - Help

## pgcli

```bash
brew tap dbcli/tap
brew install pgcli
pgcli --help
```

