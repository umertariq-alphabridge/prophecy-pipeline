## Models




## Source / Seeds

1. **sales**
Sales transaction records capturing customer purchases, shipping details, and profitability insights.

2. **customer**
Customer demographic and geographic information, aiding in market segmentation and regional analysis.

3. **product**
Catalog of products categorized by type and sub-type, aiding in inventory management and product organization.

4. **product_profit_summary**
Summary of product profitability, highlighting financial performance for individual products.


## Functions / Gems

1. **generate_schema_name**

The **generate_schema_name** macro is a versatile tool designed to streamline database schema management. It provides a flexible approach to determining the appropriate schema name for your database operations. By default, this macro returns the target schema name, ensuring consistency and alignment with your existing database configurations. However, it also allows for customization by accepting a user-defined schema name. If a custom schema name is provided, the macro will return this trimmed version, offering adaptability to various project requirements. This functionality is particularly useful for developers and database administrators who need to manage multiple schemas efficiently, ensuring that database operations are executed within the correct context.

2. **prophecy_tmp_source**

The **prophecy_tmp_source** macro is a versatile tool designed to streamline data processing within your data pipelines. This macro dynamically constructs a temporary table name based on the provided pipeline name, label, and an optional suffix. It ensures that each temporary table is uniquely identified by incorporating the current run ID, thereby preventing conflicts and maintaining data integrity across different pipeline executions. By using this macro, you can efficiently manage temporary data storage, facilitating smoother and more organized data workflows.