CREATE TABLE city
(
    city_id iSERIAL PRIMARY KEY,
    city_name VARCHAR(50) NOT NULL,
    state_id INTEGER NOT NULL,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER NOT NULL,
    modified_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    modified_by INTEGER
)

CREATE TABLE countries
(
    country_id PRIMARY KEY,
    short_name VARCHAR(3) NOT NULL,
    country_name VARCHAR(150) NOT NULL,
    phone_code INTEGER NOT NULL,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER NOT NULL,
    modified_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    modified_by INTEGER
)

CREATE TABLE modifier_group_modifier_mapping
(
    modifier_group_modifier_mapping_id SERIAL PRIMARY KEY,
    modifier_group_id INTEGER REFERENCES modifier_group(modifier_group_id) NOT NULL,,
    modifier_id INTEGER  REFERENCES modifiers(modifier_id) NOT NULL,
)

CREATE TABLE password_reset_tokens
(
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users_login(user_login_id) NOT NULL,
    token TEXT COLLATE NOT NULL,
    expiry_time TIMESTAMPTZ NOT NULL,
)

CREATE TABLE categories
(
    category_id SERIAL PRIMARY KEY,
    sort_order INTEGER,
    category_name VARCHAR(30) UNIQUE NOT NULL,
    description TEXT,
    is_deleted boolean DEFAULT FALSE,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER NOT NULL,
    modified_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    modified_by INTEGER
)

CREATE TABLE customer_reviews
(
    review_id PRIMARY KEY,
    order_id INTEGER REFERENCES orders(order_id) NOT NULL,
    food_rating DECIMAL(1) CHECK (food_rating >= 1 AND food_rating <= 5),
    service_rating DECIMAL(1) CHECK (service_rating >= 1 AND service_rating <= 5),
    ambience_rating DECIMAL(1) CHECK (ambience_rating >= 1 AND ambience_rating <= 5),
    average_rating REAL,
    comments TEXT,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER NOT NULL,
    modified_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    modified_by INTEGER
)

CREATE TABLE customers
(
    customer_id PRIMARY KEY,
    customer_name VARCHAR(30)  NOT NULL,
    email VARCHAR(100) 
    phone_no VARCHAR(15)  NOT NULL,
    total_order INTEGER DEFAULT 0,
    visit_count SMALLINT DEFAULT 0,
    order_type VARCHAR(20)  DEFAULT 'Dining'::VARCHAR,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER NOT NULL,
    modified_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    modified_by INTEGER
)

CREATE TABLE invoice
(
    invoice_id PRIMARY KEY,
    order_id INTEGER REFERENCES orders(order_id) NOT NULL,
    invoice_number VARCHAR(50)  UNIQUE NOT NULL,
    invoice_date TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
)

CREATE TABLE item_modifier_group_map
(
    item_modifier_group_id PRIMARY KEY,
    item_id INTEGER REFERENCES items(item_id) NOT NULL,
    modifier_group_id REFERENCES modifiergroup(modifier_group_id) INTEGER NOT NULL,
    min_selection_required SMALLINT DEFAULT 0,
    max_selection_allowed SMALLINT
)


CREATE TABLE items
(
    item_id PRIMARY KEY,
    item_name TEXT UNIQUE NOT NULL,
    category_id INTEGER REFERENCES category(category_id) NOT NULL,
    rate DECIMAL(10,2) NOT NULL,
    quantity INTEGER DEFAULT 1,
    unit_id INTEGER REFERENCES units(unit_id) NOT NULL,
    is_available BOOLEAN DEFAULT FALSE,
    tax_percentage DECIMAL(5,2),
    short_code VARCHAR(30),
    item_type VARCHAR(10) NOT NULL DEFAULT 'Veg'::VARCHAR,
    is_favourite BOOLEAN DEFAULT FALSE,
    is_defaulttax BOOLEAN DEFAULT FALSE,
    item_image TEXT,
    description TEXT,
    is_deleted boolean DEFAULT FALSE,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER NOT NULL,
    modified_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    modified_by INTEGER
    
    CONSTRAINT chk_item_type
        CHECK (item_type IN ('Veg', 'Non-Veg', 'Vegan'))
)
