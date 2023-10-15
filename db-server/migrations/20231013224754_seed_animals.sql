-- +goose Up
-- +goose StatementBegin
INSERT INTO animal(name) VALUES ("Raven"), ("Toby"), ("Shaggy"), ("Donovan"), ("Nee-nee"), ("Raymond");
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DELETE FROM animal;
-- +goose StatementEnd
