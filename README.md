# Notreve Gateway SMS — Painel

Painel web do **Notreve Gateway SMS**: autentica na API, gerencia aparelhos, mensagens, webhooks e tokens, e recebe eventos em tempo real (SSE).

> Fork de [android-sms-gateway/web-dashboard](https://github.com/android-sms-gateway/web-dashboard), mantido pela **Notreve Tecnologia**.
> Licença Apache 2.0 — veja [LICENSE](LICENSE) e [NOTICE](NOTICE).

## Como funciona

```text
Navegador  <->  Painel (este repo)  <->  Notreve Gateway SMS (API)
                      ^
                      +-- webhooks/SSE
```

- O painel valida usuário/senha na API e mantém a sessão em cookie.
- Cada sessão registra webhooks na API para receber eventos e empurrar por SSE ao navegador.

## Requisitos

- Docker ou Go 1.26+ com Node 20+
- API do gateway acessível por HTTPS

## Configuração

| Variável | Padrão | Descrição |
|---|---|---|
| `HTTP__ADDRESS` | `127.0.0.1:3000` | Endereço de escuta |
| `GATEWAY__URL` | `https://api.sms-gate.app/3rdparty/v1` | API 3rd party do gateway |
| `GATEWAY__WEBHOOK_URL` | `http://localhost:3000/api/webhooks/callback` | Callback público do painel |

Exemplo:

```env
HTTP__ADDRESS=0.0.0.0:3000
GATEWAY__URL=https://gateway.seu-dominio.com.br/api/3rdparty/v1
GATEWAY__WEBHOOK_URL=https://painel.seu-dominio.com.br/api/webhooks/callback
```

## Docker

```bash
docker build -t notreve-gateway-sms-dashboard .
docker run -d --name notreve-dashboard \
  -p 3000:3000 \
  -e HTTP__ADDRESS=0.0.0.0:3000 \
  -e GATEWAY__URL=https://gateway.seu-dominio.com.br/api/3rdparty/v1 \
  -e GATEWAY__WEBHOOK_URL=https://painel.seu-dominio.com.br/api/webhooks/callback \
  notreve-gateway-sms-dashboard
```

## Build local

```bash
make build   # compila o frontend (web) e o binário Go
./bin/web-dashboard
```

## Licença e atribuição

Fork de [android-sms-gateway/web-dashboard](https://github.com/android-sms-gateway/web-dashboard), Copyright Aleksandr Soloshenko, Apache 2.0.
Alterações desta versão: marca, textos, tema e melhorias próprias da Notreve.

Contato: suporte@notreve.com.br — https://notreve.com.br
