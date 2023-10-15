-- +goose Up
-- +goose StatementBegin
CREATE TABLE animal (
    id      bigint auto_increment primary key,
    name    varchar(128)
);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE animal;
-- +goose StatementEnd
