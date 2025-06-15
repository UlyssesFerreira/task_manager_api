# 📦 Task Manager API

Uma API RESTful desenvolvida em Ruby on Rails com autenticação JWT.

---

## 🔐 Configuração do JWT

Este projeto usa autenticação JWT. Para isso, defina a variável de ambiente `JWT_SECRET`.

### 1. Crie um arquivo `.env`

```bash
cp .env.example .env
```
### 2. Gere um valor para JWT_SECRET com SecureRandom
```bash
rails console
```
```ruby
SecureRandom.hex(64) # Gera uma string de 128 caracteres (64 bytes)
```
### 3. Coloque a string gerada no arquivo `.env`
```
JWT_SECRET=string_gerada_aqui
```

## 🚀 Como rodar o projeto

```bash
# Instale as dependências
bundle install

# Configure o banco de dados
rails db:create db:migrate

# Rode o servidor
rails server
```

---

## 🔐 Autenticação

Esta API utiliza autenticação via **token JWT**.

- Faça uma requisição `POST /api/v1/login` com:

```json
{
  "email": "usuario@example.com",
  "password": "senha123"
}
```

- O retorno será:

```json
{
  "access_token": "eyJhbGciOiJIUzI1...",
  "expires_at": "2025-06-01T12:59:59.000-03:00"
}
```

- Use o token no header `Authorization`:

```
Authorization: Bearer <token>
```

---

## 📚 Documentação da API

A documentação interativa está disponível em:

👉 [`http://localhost:3000/api-docs`](http://localhost:3000/api-docs)

Através dela, você pode explorar e testar os endpoints diretamente no navegador.

---

## 🛠 Stack utilizada

- Ruby on Rails 8
- PostgreSQL
- Rswag (Swagger)
- RSpec
- JWT

---
