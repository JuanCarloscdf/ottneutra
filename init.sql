-- TABLAS SIN FOREIGN KEYS

CREATE TABLE enterprice (
    enter_id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    nit TEXT NOT NULL,
    adress TEXT NOT NULL,
    phone TEXT NOT NULL UNIQUE,
    url_icon TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    color TEXT,
    rep_name TEXT NOT NULL,
    rep_email TEXT NOT NULL,
    rep_cellphone TEXT NOT NULL
);

CREATE INDEX idx_enterprice_email ON enterprice (email);

CREATE TABLE categories (
    cat_id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE channels (
    channel_id SERIAL PRIMARY KEY,
    cat_id INTEGER NOT NULL,
    name TEXT NOT NULL,
    logo_url TEXT
);

CREATE TABLE product (
    product_id SERIAL PRIMARY KEY,
    name TEXT,
    price BIGINT,
    description TEXT,
    characteristics TEXT
);

CREATE TABLE plan (
    plan_id SERIAL PRIMARY KEY,
    enter_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    total_credits BIGINT NOT NULL,
    used_credits BIGINT NOT NULL DEFAULT 0,
    start DATE NOT NULL,
    "end" DATE NOT NULL
);
CREATE INDEX idx_plan_enter_id ON plan (enter_id);

CREATE TABLE prod_channel (
    product_id INTEGER NOT NULL,
    channel_id INTEGER NOT NULL,
    PRIMARY KEY (product_id, channel_id)
);

CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    enter_id INTEGER NOT NULL,
    name TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    ci TEXT,
    username TEXT NOT NULL,
    password TEXT NOT NULL
);

CREATE INDEX idx_use_email ON users (email);
CREATE INDEX idx_users_username ON users (username);

CREATE TABLE subscriptions (
    pack_id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    plan_id INTEGER NOT NULL,
    start DATE NOT NULL,
    "end" DATE NOT NULL
);

CREATE TABLE payments (
    payment_id SERIAL PRIMARY KEY,
    plan_id INTEGER NOT NULL,
    sale_id INTEGER NOT NULL,
    amount BIGINT NOT NULL,
    method TEXT NOT NULL,
    status TEXT NOT NULL,
    payment_date DATE NOT NULL
);

-- FOREIGN KEYS AÑADIDAS AL FINAL

ALTER TABLE channels
ADD CONSTRAINT fk_categories_channels FOREIGN KEY (cat_id) REFERENCES categories (cat_id) ON DELETE CASCADE;

ALTER TABLE plan
ADD CONSTRAINT fk_enterprice_plan FOREIGN KEY (enter_id) REFERENCES enterprice (enter_id) ON DELETE CASCADE;

ALTER TABLE plan
ADD CONSTRAINT fk_product_plan FOREIGN KEY (product_id) REFERENCES product (product_id) ON DELETE CASCADE;

ALTER TABLE prod_channel
ADD CONSTRAINT fk_product_prod_channel FOREIGN KEY (product_id) REFERENCES product (product_id) ON DELETE CASCADE;

ALTER TABLE prod_channel
ADD CONSTRAINT fk_channels_prod_channel FOREIGN KEY (channel_id) REFERENCES channels (channel_id) ON DELETE CASCADE;

ALTER TABLE users
ADD CONSTRAINT fk_enterprice_users FOREIGN KEY (enter_id) REFERENCES enterprice (enter_id) ON DELETE CASCADE;

ALTER TABLE subscriptions
ADD CONSTRAINT fk_plan_subscriptions FOREIGN KEY (plan_id) REFERENCES plan (plan_id) ON DELETE CASCADE;

ALTER TABLE subscriptions
ADD CONSTRAINT fk_users_subscriptions FOREIGN KEY (user_id) REFERENCES users (user_id) ON DELETE CASCADE;

ALTER TABLE payments
ADD CONSTRAINT fk_plan_payments FOREIGN KEY (plan_id) REFERENCES plan (plan_id) ON DELETE CASCADE;