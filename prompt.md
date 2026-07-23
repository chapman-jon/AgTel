I have a project that I need you to work on. I wrote up the corresponding problem statement in the parity_problem_statement.md file, please read it for context.

Then we need to bulid a parity table that represents a Venn diagram, showing the overlap of active fields in Digital
with analogous types of fields in BST and SAP (one circle for each source).
Each row in the table should indicate which section of the Venn Diagram it represents and the count for how many fields are in that section.
This table will actually feed into a Venn diagram dashboard for leadership. They will use this to visually evaluate parity across the 3 systems.
Exports of data from all 3 systems are on my machine for you to use as source data.
Parity of fields should be determined using enterprise ID's.
A field from system A is in parity with a field from system B when the fields' enterprise IDs match, and the corresonding
farm and farmer in each system also have matching enterprise ID's.
If they aren't in parity, they are considered separate fields (at least according to our sources) even if they actually represent the same physical field in real life.
A field can be in parity in all 3 systems (I just used 2 sources in that example).
Also, null is never considered to be equal to null when considering parity.

This table is going to live in Snowflake, our enterprise warehouse, and we will use dbt, our enterprise pipeline tool. However, it is not necessary to do our development in Snowflake - instead we can do our development in DuckDB. You will need to install DuckDB and dbt with pip, then develop the solution locally. Use the csv's I provided for your source data. Once you've developed the solution, I will deploy the solution to a production schema in Snowflake (this is a simple config change). This is where the data can be queried and the data will feed into a Venn diagram dashboard in our BI tool. You don't have to worry about building the dashboard, I just mention this aspect as context.

Once you have built and run the pipeline and the parity table is in your local DuckDB, please export a csv of the table for me to review. 

Additionally, leadership wants a single metric that tracks "Overall Field Parity".
For this, you can again use dbt + DuckDB (same dbt project), but it will just be a table with a single cell containing the measurement value. The value should be the count for the center of the Venn diagram, divided by the counts for all sections. Again export this table to a csv for me to review.

This concludes the instructions, please complete the project as described.