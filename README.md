# Task 14: Stored Procedures & User-Defined Functions

## Objective
To build reusable database logic using **Stored Procedures** and **User-Defined Functions**, similar to real backend systems.

---

## Tools Used
- MySQL Workbench
- Alternative Databases:
  - PostgreSQL
  - BigQuery Sandbox
  - SQLite (limited support for procedures)

---

## Database Structure
### Employees Table
| Column | Type | Description |
|------|-----|------------|
| emp_id | INT | Primary Key |
| emp_name | VARCHAR | Employee Name |
| department | VARCHAR | Department |
| salary | DECIMAL | Monthly Salary |
| hire_date | DATE | Auto current date |

---

## Stored Procedures

### 1. `add_employee`
**Purpose:**  
Insert employee data with validation.

**Parameters:**
- Name
- Department
- Salary

**Features:**
- Input parameters
- Error handling using `SIGNAL`
- Reusable business logic

**Usage:**
```sql
CALL add_employee('Anvesh', 'IT', 50000);
