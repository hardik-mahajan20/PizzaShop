CREATE TABLE countries
(
    country_id SERIAL PRIMARY KEY,
    short_name VARCHAR(5) NOT NULL,
    country_name VARCHAR(150) NOT NULL,
    phone_code INTEGER NOT NULL,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER NOT NULL,
    modified_at TIMESTAMPTZ,
    modified_by INTEGER
);

CREATE TABLE states
(
    state_id SERIAL PRIMARY KEY,
    state_name VARCHAR(50) NOT NULL,
    country_id INTEGER REFERENCES countries(country_id) NOT NULL,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER NOT NULL,
    modified_at TIMESTAMPTZ,
    modified_by INTEGER
);

CREATE TABLE cities
(
    city_id SERIAL PRIMARY KEY,
    city_name VARCHAR(50) NOT NULL,
    state_id INTEGER REFERENCES states(state_id) NOT NULL,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER NOT NULL,
    modified_at TIMESTAMPTZ,
    modified_by INTEGER
);

CREATE TABLE roles
(
    role_id SERIAL PRIMARY KEY,
    role_name VARCHAR(30) UNIQUE NOT NULL
);

CREATE TABLE permission_modules
(
    module_id SERIAL PRIMARY KEY,
    module_name VARCHAR(30) UNIQUE NOT NULL
);

CREATE TABLE permissions
(
    permission_id SERIAL PRIMARY KEY,
    role_id INTEGER REFERENCES roles(role_id) NOT NULL,
    module_id INTEGER REFERENCES permission_modules(module_id) NOT NULL,
    can_view BOOLEAN DEFAULT TRUE,
    can_add_edit BOOLEAN DEFAULT TRUE,
    can_delete BOOLEAN DEFAULT TRUE
);

CREATE TABLE users
(
    user_id SERIAL PRIMARY KEY,
    role_id INTEGER REFERENCES roles(role_id) NOT NULL,
    user_name VARCHAR,
    email VARCHAR(100) UNIQUE,
    password_hash TEXT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone_number VARCHAR(15) UNIQUE NOT NULL,
    profile_image TEXT ,
    address TEXT ,
    zip_code VARCHAR(10) ,
    country_id INTEGER REFERENCES countries(country_id) NOT NULL,
    state_id INTEGER REFERENCES states(state_id) NOT NULL,
    city_id INTEGER REFERENCES cities(city_id) NOT NULL,
    status INTEGER DEFAULT 1,
    is_deleted BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER NOT NULL,
    modified_at TIMESTAMPTZ,
    modified_by INTEGER
);

CREATE TABLE users_logins
(
    user_login_id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(user_id),
    role_id INTEGER REFERENCES roles(role_id) NOT NULL,
    email VARCHAR UNIQUE,
    password_hash TEXT,
    refresh_token TEXT ,
    reset_token TEXT ,
    reset_token_expiration TIMESTAMPTZ,
    is_first_login BOOLEAN NOT NULL DEFAULT TRUE,
    is_reset_token_used BOOLEAN DEFAULT FALSE
);

CREATE TABLE password_reset_tokens
(
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users_logins(user_login_id) NOT NULL,
    token TEXT NOT NULL,
    expiry_time TIMESTAMPTZ NOT NULL
);

CREATE TABLE units
(
    unit_id SERIAL PRIMARY KEY,
    unit_name VARCHAR(50) NOT NULL,
    short_name VARCHAR(20)
);

CREATE TABLE categories
(
    category_id SERIAL PRIMARY KEY,
    sort_order INTEGER,
    category_name VARCHAR(30) UNIQUE NOT NULL,
    description TEXT,
    is_deleted BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER NOT NULL,
    modified_at TIMESTAMPTZ,
    modified_by INTEGER
);

CREATE TABLE items
(
    item_id SERIAL PRIMARY KEY,
    category_id INTEGER REFERENCES categories(category_id) NOT NULL,
    item_name TEXT UNIQUE NOT NULL,
    rate DECIMAL(10,2) NOT NULL,
    quantity INTEGER DEFAULT 1,
    unit_id INTEGER REFERENCES units(unit_id) NOT NULL,
    is_available BOOLEAN DEFAULT FALSE,
    tax_percentage DECIMAL(5,2),
    short_code VARCHAR(30),
    item_type VARCHAR(10) NOT NULL DEFAULT 'Veg'::VARCHAR,
    is_favorite BOOLEAN DEFAULT FALSE,
    is_default_tax BOOLEAN DEFAULT FALSE,
    item_image TEXT,
    description TEXT,
    is_deleted boolean DEFAULT FALSE,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER NOT NULL,
    modified_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    modified_by INTEGER,
    
    CONSTRAINT chk_item_type
        CHECK (item_type IN ('Veg', 'Non-Veg', 'Vegan'))
);

CREATE TABLE modifier_groups
(
    modifier_group_id SERIAL PRIMARY KEY,
    sort_order INTEGER,
    modifier_group_name VARCHAR(30) UNIQUE NOT NULL,
    description TEXT,
    is_deleted BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER NOT NULL,
    modified_at TIMESTAMPTZ,
    modified_by INTEGER
);

CREATE TABLE modifiers
(
    modifier_id SERIAL PRIMARY KEY,
    modifier_type INTEGER,
    modifier_name TEXT UNIQUE NOT NULL,
    unit_id INTEGER REFERENCES units(unit_id) NOT NULL,
    rate DECIMAL(10,2) NOT NULL,
    quantity INTEGER,
    description TEXT,
    is_deleted BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER NOT NULL,
    modified_at TIMESTAMPTZ,
    modified_by INTEGER
);

CREATE TABLE modifier_group_modifier_mappings
(
    modifier_group_modifier_mapping_id SERIAL PRIMARY KEY,
    modifier_group_id INTEGER REFERENCES modifier_groups(modifier_group_id) NOT NULL,
    modifier_id INTEGER  REFERENCES modifiers(modifier_id) NOT NULL
);

CREATE TABLE item_modifier_group_map
(
    item_modifier_group_id SERIAL PRIMARY KEY,
    item_id INTEGER REFERENCES items(item_id) NOT NULL,
    modifier_group_id INTEGER REFERENCES modifier_groups(modifier_group_id) NOT NULL,
    min_selection_required SMALLINT DEFAULT 0,
    max_selection_allowed SMALLINT
);

CREATE TABLE sections
(
    section_id SERIAL PRIMARY KEY,
    section_name VARCHAR(30) UNIQUE NOT NULL,
    section_order INT NOT NULL,
    description TEXT,
    is_deleted BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER NOT NULL,
    modified_at TIMESTAMPTZ,
    modified_by INTEGER
);

CREATE TABLE tables
(
    table_id SERIAL PRIMARY KEY,
    section_id INTEGER REFERENCES sections(section_id),
    table_name VARCHAR(20) NOT NULL,
    table_status INTEGER DEFAULT 1,
    capacity INTEGER NOT NULL,
    is_deleted BOOLEAN DEFAULT false,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER NOT NULL,
    modified_at TIMESTAMPTZ,
    modified_by INTEGER
);

CREATE TABLE taxes
(
    tax_id SERIAL PRIMARY KEY,
    tax_name VARCHAR(10) NOT NULL,
    is_enabled BOOLEAN DEFAULT TRUE,
    is_inclusive BOOLEAN DEFAULT FALSE,
    tax_value REAL NOT NULL DEFAULT 0,
    is_default BOOLEAN DEFAULT TRUE,
    tax_type VARCHAR(20) NOT NULL,
    is_deleted BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER NOT NULL,
    modified_at TIMESTAMPTZ,
    modified_by INTEGER
);

CREATE TABLE customers
(
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(30) NOT NULL,
    email VARCHAR(100),
    phone_no VARCHAR(15) NOT NULL,
    total_order INTEGER DEFAULT 0,
    visit_count SMALLINT DEFAULT 0,
    order_type VARCHAR(20) DEFAULT 'Dining'::VARCHAR,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER NOT NULL,
    modified_at TIMESTAMPTZ,
    modified_by INTEGER
);

CREATE TABLE orders
(
    order_id SERIAL PRIMARY KEY,
    order_date TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    customer_id INTEGER REFERENCES customers(customer_id) NOT NULL,
    payment_mode VARCHAR(20),
    order_wise_comment TEXT,
    no_of_person SMALLINT,
    rating DECIMAL(2,1) CHECK (rating >=0 AND rating <= 5) DEFAULT 0,
    sub_amount DECIMAL(10,2),
    discount DECIMAL(3,0),
    total_tax DECIMAL(10,2),
    total_amount DECIMAL(10,2) NOT NULL,
    status INTEGER NOT NULL DEFAULT 0,
    order_type VARCHAR(20) DEFAULT 'Dining'::VARCHAR,
    invoice_number VARCHAR(50),
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER NOT NULL,
    modified_at TIMESTAMPTZ,
    modified_by INTEGER
);

CREATE TABLE ordered_items
(
    ordered_item_id SERIAL PRIMARY KEY,
    order_id INTEGER REFERENCES orders(order_id) NOT NULL,
    item_id INTEGER REFERENCES items(item_id) NOT NULL,
    item_wise_comment TEXT,
    quantity INTEGER NOT NULL DEFAULT 1,
    ready_quantity INTEGER NOT NULL DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    served_at TIMESTAMPTZ
);

CREATE TABLE ordered_item_modifiers
(
    modified_item_id SERIAL PRIMARY KEY,
    ordered_item_id INTEGER REFERENCES ordered_items(ordered_item_id) NOT NULL,
    quantity INTEGER NOT NULL DEFAULT 1,
    order_id INTEGER REFERENCES orders(order_id) NOT NULL,
    item_modifier_id INTEGER REFERENCES modifiers(modifier_id) NOT NULL
);

CREATE TABLE order_tables
(
    order_table_id SERIAL PRIMARY KEY,
    order_id INTEGER REFERENCES orders(order_id) NOT NULL,
    table_id INTEGER REFERENCES tables(table_id) NOT NULL
);

CREATE TABLE order_tax_mapping
(
    order_tax_id SERIAL PRIMARY KEY,
    order_id INTEGER REFERENCES orders(order_id) NOT NULL,
    tax_id INTEGER REFERENCES taxes(tax_id) NOT NULL,
    tax_value REAL
);

CREATE TABLE waiting_tokens
(
    waiting_token_id SERIAL PRIMARY KEY,
    customer_id INTEGER REFERENCES customers(customer_id) NOT NULL,
    no_of_people INTEGER NOT NULL,
    section_id INTEGER REFERENCES sections(section_id) NOT NULL,
    is_assigned boolean DEFAULT false,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER NOT NULL,
    modified_at TIMESTAMPTZ,
    modified_by INTEGER
);

CREATE TABLE waiting_table_mappings
(
    waiting_table_id SERIAL PRIMARY KEY,
    waiting_token_id INTEGER REFERENCES waiting_tokens(waiting_token_id) NOT NULL,
    table_id INTEGER REFERENCES tables(table_id) NOT NULL
);

CREATE TABLE invoice
(
    invoice_id SERIAL PRIMARY KEY,
    order_id INTEGER REFERENCES orders(order_id) NOT NULL,
    invoice_number VARCHAR(50) UNIQUE NOT NULL,
    invoice_date TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE customer_reviews
(
    review_id SERIAL PRIMARY KEY,
    order_id INTEGER REFERENCES orders(order_id) NOT NULL,
    food_rating DECIMAL(1) CHECK (food_rating >= 1 AND food_rating <= 5),
    service_rating DECIMAL(1) CHECK (service_rating >= 1 AND service_rating <= 5),
    ambience_rating DECIMAL(1) CHECK (ambience_rating >= 1 AND ambience_rating <= 5),
    average_rating REAL,
    comments TEXT,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER NOT NULL,
    modified_at TIMESTAMPTZ,
    modified_by INTEGER
);

