FROM golang:1.18-alpine

WORKDIR /go

COPY src/v1.json .

RUN mkdir -p "backend/v1"

RUN go install github.com/deepmap/oapi-codegen/cmd/oapi-codegen@latest \
    && oapi-codegen --old-config-style --generate="gin" --package=openapi v1.json > /go/backend/v1/v1.gin.gen.go \
    && oapi-codegen --old-config-style --generate="types" --package=openapi v1.json > /go/backend/v1/v1.types.gen.go \
