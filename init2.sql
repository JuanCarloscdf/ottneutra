-- Tabla de Categorías
CREATE TABLE categories (
  cat_id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL UNIQUE,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

-- Tabla de Canales
CREATE TABLE channels (
  channel_id SERIAL PRIMARY KEY,
  cat_id INT NOT NULL,
  name VARCHAR(100) NOT NULL,
  logo_url TEXT NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

-- Tabla de Empresas
CREATE TABLE company (
  enter_id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(150) NOT NULL UNIQUE,
  nit VARCHAR(50) NOT NULL,
  address VARCHAR(150) NOT NULL,
  phone VARCHAR(20),
  url_icon TEXT,
  color VARCHAR(20) NOT NULL,
  rep_name VARCHAR(100) NOT NULL,
  rep_email VARCHAR(100) NOT NULL,
  rep_cellphone VARCHAR(20) NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

-- Tabla de Productos
CREATE TABLE product (
  product_id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL UNIQUE,
  price INT NOT NULL,
  description TEXT NOT NULL,
  characteristics JSON,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

-- Asociación Producto-Canal
CREATE TABLE prod_channel (
  id SERIAL PRIMARY KEY,
  product_id INT NOT NULL,
  channel_id INT NOT NULL,
  UNIQUE (product_id, channel_id),
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

-- Planes por Empresa
CREATE TABLE company_plans (
  company_plan_id SERIAL PRIMARY KEY,
  product_id INT NOT NULL,
  enter_id INT NOT NULL,
  start DATE NOT NULL,
  end DATE NOT NULL,
  total_credits INT NOT NULL,
  used_credits INT NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

-- Facturas
CREATE TABLE invoice (
  invoice_id SERIAL PRIMARY KEY,
  company_plan_id INT NOT NULL,
  product_id INT NOT NULL,
  quantity INT,
  unit_price INT,
  total_amount INT,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

-- Usuarios
CREATE TABLE users (
  user_id SERIAL PRIMARY KEY,
  enter_id INT NOT NULL,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(100) NOT NULL UNIQUE,
  username VARCHAR(50),
  password VARCHAR(100),
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

-- Planes por Usuario
CREATE TABLE user_plans (
  user_plan_id SERIAL PRIMARY KEY,
  user_id INT NOT NULL,
  plan_id INT NOT NULL,
  start DATE NOT NULL,
  end DATE NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

-- 🔗 Relaciones (FOREIGN KEY)
ALTER TABLE channels
  ADD CONSTRAINT fk_channels_category
  FOREIGN KEY (cat_id)
  REFERENCES categories (cat_id)
  ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE prod_channel
  ADD CONSTRAINT fk_prod_channel_product
  FOREIGN KEY (product_id)
  REFERENCES product (product_id)
  ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE prod_channel
  ADD CONSTRAINT fk_prod_channel_channel
  FOREIGN KEY (channel_id)
  REFERENCES channels (channel_id)
  ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE company_plans
  ADD CONSTRAINT fk_cp_product
  FOREIGN KEY (product_id)
  REFERENCES product (product_id)
  ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE company_plans
  ADD CONSTRAINT fk_cp_company
  FOREIGN KEY (enter_id)
  REFERENCES company (enter_id)
  ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE invoice
  ADD CONSTRAINT fk_invoice_cp
  FOREIGN KEY (company_plan_id)
  REFERENCES company_plans (company_plan_id)
  ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE invoice
  ADD CONSTRAINT fk_invoice_product
  FOREIGN KEY (product_id)
  REFERENCES product (product_id)
  ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE users
  ADD CONSTRAINT fk_users_company
  FOREIGN KEY (enter_id)
  REFERENCES company (enter_id)
  ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE user_plans
  ADD CONSTRAINT fk_up_user
  FOREIGN KEY (user_id)
  REFERENCES users (user_id)
  ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE user_plans
  ADD CONSTRAINT fk_up_plan
  FOREIGN KEY (plan_id)
  REFERENCES company_plans (company_plan_id)
  ON DELETE CASCADE ON UPDATE CASCADE;

CREATE INDEX idx_channels_cat_id ON channels (cat_id);
CREATE INDEX idx_users_enter_id ON users (enter_id);
CREATE INDEX idx_company_plans_enter_id ON company_plans (enter_id);
CREATE INDEX idx_company_plans_product_id ON company_plans (product_id);
CREATE INDEX idx_invoice_company_plan_id ON invoice (company_plan_id);
CREATE INDEX idx_invoice_product_id ON invoice (product_id);
CREATE INDEX idx_user_plans_user_id ON user_plans (user_id);
CREATE INDEX idx_user_plans_plan_id ON user_plans (plan_id);
CREATE INDEX idx_prod_channel_product_id ON prod_channel (product_id);
CREATE INDEX idx_prod_channel_channel_id ON prod_channel (channel_id);

CREATE INDEX idx_company_plans_start ON company_plans (start);
CREATE INDEX idx_company_plans_end ON company_plans (end);
CREATE INDEX idx_user_plans_start ON user_plans (start);
CREATE INDEX idx_user_plans_end ON user_plans (end);

CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;
