FROM node:22-alpine

WORKDIR /app

COPY package.json package-lock.json* ./
RUN npm install --omit=dev --no-audit --no-fund

COPY src ./src
COPY tools ./tools

# O grupo 6000 e o mesmo do socket do agente no host. Sem ele o painel nao
# consegue abrir o socket - e e assim que a permissao fica explicita, em vez
# de depender de o container rodar como root.
RUN addgroup -g 6000 painel && adduser -D -u 6000 -G painel painel

ENV NODE_ENV=production
EXPOSE 3100

USER painel
CMD ["node", "src/index.js"]
