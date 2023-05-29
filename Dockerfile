# build stage
FROM node:alpine as builder
WORKDIR '/usr/src/app'
COPY package.json .
RUN npm install
COPY ./ ./
RUN npm run build

# run stage
FROM nginx
# --from=builder: 다른 스테이지에 있는 파일을 복사할 때 다른 스테이지 이름을 명시
# /usr/src/app/build: builder 스테이제엇 생성된 파일 (복사할 파일)
# /usr/share/nginx/html: Nginx가 사용할 수 있는 위치로 파일을 복사한다.
COPY --from=builder /usr/src/app/build /usr/share/nginx/html