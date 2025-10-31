# Transaction Simulator

A Ruby on Rails application for simulating financial transactions between user accounts. This web application allows you to transfer funds between accounts, track transaction history, and manage user balances.

## Features

- **User Management**: Support for both individual users and companies
- **Account Management**: Each user can have an account with a balance
- **Transaction Processing**: Transfer funds between accounts with balance validation
- **Transaction History**: View all transactions with details about sender, recipient, amount, and timestamp
- **Real-time Balance Updates**: Account balances are automatically updated when transactions are processed
- **Database Transactions**: Ensures data integrity with ACID-compliant database transactions

## Technology Stack

- **Ruby**: 3.2.2
- **Rails**: 8.1.0
- **Database**: SQLite3
- **Server**: Puma with Thruster
- **Asset Pipeline**: Propshaft
- **JavaScript**: Importmaps with Turbo and Stimulus

## Prerequisites

Before you begin, ensure you have the following installed:

- Ruby 3.2.2 (use `.ruby-version` for version management)
- Bundler gem
- SQLite3

## Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd transaction_simulator
   ```

2. **Install dependencies**
   ```bash
   bundle install
   ```

3. **Set up the database**
   ```bash
   bin/rails db:create
   bin/rails db:migrate
   ```

4. **Seed the database (optional)**
   ```bash
   bin/rails db:seed
   ```
   This will create:
   - 10 individual users with accounts (balances between $1,000-$5,000)
   - 5 companies with accounts (balances between $10,000-$50,000)

## Running the Application

### Development Mode

1. **Start the Rails server**
   ```bash
   bin/rails server
   ```

2. **Visit the application**
   Open your browser and navigate to `http://localhost:3000`

### Running Tests

```bash
# Run all tests
bin/rails test

# Run system tests
bin/rails test:system
```

### Code Quality

```bash
# Lint with RuboCop
bin/rubocop

# Security scan with Brakeman
bin/brakeman

# Audit gem dependencies
bin/bundler-audit
```

## Usage

1. **View Transactions**: The home page displays a list of all transactions, showing:
   - Sender account
   - Recipient account
   - Transaction amount
   - Date and time

2. **Create a Transaction**:
   - Select a "From Account" from the dropdown
   - Select a "To Account" from the dropdown
   - Enter the transfer amount
   - Click "Transfer Money"

3. **Validation**: The application will prevent:
   - Transferring to the same account
   - Transfers exceeding the sender's balance
   - Invalid account selections

## Project Structure

```
transaction_simulator/
├── app/
│   ├── controllers/
│   │   └── transactions_controller.rb  # Handles transaction creation and listing
│   ├── models/
│   │   ├── user.rb                      # User model (person or company)
│   │   ├── account.rb                   # Account model with balance
│   │   └── transaction.rb               # Transaction model
│   └── views/
│       └── transactions/
│           └── index.html.erb           # Main transaction interface
├── db/
│   ├── migrate/                         # Database migrations
│   ├── schema.rb                        # Database schema
│   └── seeds.rb                         # Seed data generator
└── config/
    └── routes.rb                        # Application routes
```

## Database Schema

### Users
- `id`: Primary key
- `name`: User/Company name
- `user_type`: Type of user ('person' or 'company')
- `created_at`, `updated_at`: Timestamps

### Accounts
- `id`: Primary key
- `user_id`: Foreign key to users
- `balance`: Decimal amount (precision: 15, scale: 2)
- `created_at`, `updated_at`: Timestamps

### Transactions
- `id`: Primary key
- `from_account_id`: Foreign key to accounts (sender)
- `to_account_id`: Foreign key to accounts (recipient)
- `amount`: Decimal amount (precision: 15, scale: 2)
- `created_at`, `updated_at`: Timestamps

## Deployment

This application is configured for deployment with Kamal. For production deployment:

1. **Configure secrets**
   - Set up `config/master.key` (do NOT commit this file)
   - Configure `.kamal/secrets` with required environment variables

2. **Update deployment configuration**
   - Edit `config/deploy.yml` with your server details
   - Configure registry settings if using a container registry

3. **Deploy**
   ```bash
   bin/kamal deploy
   ```

For Docker deployment without Kamal:

```bash
docker build -t transaction_simulator .
docker run -d -p 80:80 -e RAILS_MASTER_KEY=<your-master-key> transaction_simulator
```

## Development

### Adding New Features

The application follows standard Rails conventions:
- Controllers in `app/controllers/`
- Models in `app/models/`
- Views in `app/views/`
- Routes in `config/routes.rb`

### Database Migrations

```bash
# Create a new migration
bin/rails generate migration MigrationName

# Run migrations
bin/rails db:migrate

# Rollback last migration
bin/rails db:rollback
```

## Security

- Sensitive parameters are filtered from logs (see `config/initializers/filter_parameter_logging.rb`)
- Database transactions ensure atomicity for balance transfers
- Account locking prevents race conditions during concurrent transfers

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Built with [Ruby on Rails](https://rubyonrails.org/)
- Uses [Faker](https://github.com/faker-ruby/faker) for generating seed data
