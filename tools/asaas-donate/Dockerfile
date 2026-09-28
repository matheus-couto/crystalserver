FROM node:22-alpine

WORKDIR /app

# Copia so os manifestos primeiro: enquanto eles nao mudarem, o npm ci vem
# do cache e o rebuild da imagem leva segundos.
COPY package.json package-lock.json ./
RUN npm ci --omit=dev

COPY index.js ./

# O .env nao entra na imagem. Ele vem por env_file no compose, para a chave
# da API nao ficar gravada em uma camada.
ENV NODE_ENV=production

EXPOSE 3000

CMD ["node", "index.js"]
