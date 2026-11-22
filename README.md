# Online Bookstore Sales Analysis using PostgreSQL

## Project overview
This project uses PostgreSQL to explore an online bookstore dataset. It contains book, customer, and order records and SQL queries examining book categories, prices, orders, customer purchasing activity, sales revenue, and stock.

## Tools and skills
- PostgreSQL
- SQL: `CREATE TABLE`, primary and foreign keys, `SELECT`, `WHERE`, `BETWEEN`, `DISTINCT`, `ORDER BY`, `LIMIT`, `SUM`, `AVG`, `COUNT`, `GROUP BY`, `HAVING`, `INNER JOIN`, `LEFT JOIN`, and `COALESCE`.

## Dataset
| Source file | SQL table | Rows | Columns |
| --- | --- | ---: | ---: |
| `Books.csv` | `Books` | 500 | 7 |
| `Customers.csv` | `Customer` | 500 | 6 |
| `Orders.csv` | `Orders` | 500 | 6 |

### Table fields
- **Books:** `Book_ID` (primary key), `Title`, `Author`, `Genre`, `Published_Year`, `Price`, `Stock`.
- **Customer:** `Customer_ID` (primary key), `Name`, `Email` (unique), `Phone`, `City`, `Country`.
- **Orders:** `Order_ID` (primary key), `Customer_ID` (foreign key), `Book_ID` (foreign key), `Order_Date`, `Quantity`, `Total_Amount`.

`Orders` links each order to a customer and a book.

## Repository contents
```text
online-bookstore-sql-analysis/
├── README.md
├── data/
│   ├── Books.csv
│   ├── Customers.csv
│   └── Orders.csv
└── sql/
    └── book_store_project.sql
```

## SQL analysis
The SQL script includes 11 basic and 9 advanced analytical questions.

**Basic queries:** Fiction books; books published after 1950; Canadian customers; orders in November 2023; total book stock; highest-priced book; orders with quantity greater than one; orders above 20 in total amount; available genres; lowest-stock book; and total order revenue.

**Advanced queries:** quantities sold by genre; average Fantasy book price; customers with at least two orders; most frequently ordered book by number of orders; three most expensive Fantasy books; quantities sold by author and book; customers/cities associated with individual orders above 30; customer with the highest total order spend; and stock minus ordered quantities by book.

## How to run
1. Create a PostgreSQL database.
2. Create tables in dependency order: `Books`, then `Customer`, then `Orders`. **Important:** The original SQL script defines `Orders` before `Customer`; rearrange the statements when running the schema in a new database.
3. Import `Books.csv` into `Books`, `Customers.csv` into `Customer`, and `Orders.csv` into `Orders`, matching the CSV headers.
4. **Date format:** `Orders.csv` uses `DD-MM-YYYY` dates. Before importing it, use a PostgreSQL session with `SET datestyle TO 'ISO, DMY';` or convert dates to ISO `YYYY-MM-DD` in a separate prepared copy. Verify the dates after import.
5. Run the analysis `SELECT` queries in `sql/book_store_project.sql`.

## Data quality checks
The three CSVs contain 1,500 records in total. The provided datasets have no blank fields, duplicate rows, duplicate primary key IDs, or broken order-to-book/customer references. Each order's `Total_Amount` matches its book `Price` multiplied by `Quantity`.

## Interpretation notes
- The query labeled *total quantity sold by author* groups by author, title, and genre, so its current results are per book rather than consolidated by author.
- The query about cities where customers spent over 30 filters individual orders over 30; it does not calculate cumulative spending per customer or list unique cities.
- The stock calculation subtracts all ordered quantities from the stock column. Without knowing whether `Stock` is opening or current stock, this is a hypothetical calculation rather than verified remaining inventory. Some calculated values are negative.
- The most frequently ordered book is ranked by the number of order records, not the number of copies sold.

## Limitations
The source of the CSV datasets, whether records are real or synthetic, the currency unit, and the definition of `Stock` are not documented in the supplied files. No claims about these are made here. The original script has not been executed against a PostgreSQL server as part of this review.
