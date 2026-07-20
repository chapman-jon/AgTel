I have a full project that I need you to work on. I wrote up the corresponding problem statement in the parity_problem_statement.md file, please read it for context.

Then please explore my docs and notes to get an understanding of the following:
- What an "active" field is in AgDigital.
- What the analogous term or definition is for an "active" field in BST and SAP.
- How to identify active fields in each of the 3 systems.
Then, do these same 3 tasks for farmers and farms as well.

Additionally, explore docs and notes to determine what sort of farmers, farms, and fields are stored in each system - this is known to be inconsistent across the 3 systems and you will need to understand the differences. Basically you will need to know how to find the data from BST and SAP that should "match up" with AD's, e.g. if BST has data on Australian fields but AD does not, you need to know that for measuring parity reasonably.

Exports of the data (farms, farmers, and fields) from all 3 systems are on my machine for you to use as source data.

Then, you need to build data pipelines, with one of the final results being a table showing parity across the 3 systems. The table should look like this:
| BST | SAP | AD | Numbers of Fields |
-------------------------------------
|    1   |    1   |  0  | 215                         |
|    1   |    0   |  0  | 514                         |
.... and so on.

The first record in that table means 215 fields were found that were in BST and SAP but not AD. The second record means 514 fields were found that were in BST but not SAP or AD. You can think of this as a Venn diagram where each circle represents fields in a given system (e.g. the first record would be represented in the Venn diagram as the section where the BST circle overlaps with the SAP circle, but does not overlap with the AD circle). 
In fact, we need this table because it will feed into a Venn diagram dashboard for leadership. They will use this to visually evaluate parity across the 3 systems.

To measure parity, you need to first determine what SHOULD be in parity with AD. Using the example I gave earlier, if BST has data on Australian fields but AD does not, you should filter out the Australian BST fields prior to evaluating parity. Expecting BST Australian fields to be in parity with BST fields would make no sense. This is just an example - you will need to explore the docs to determine this.

Once you've applied these sorts of rules so that you have data from all 3 sources containing what should be in parity, you need to measure parity by leveraging enterprise ID's. Basically, if you see a field in BST, a field in SAP, and a field in AD that all have the same enterprise ID, then this represents a field that is in all 3 systems. However, AgDigital leadership only considers a field to be in parity if additionally the field's farm and the farm's farmer match. This means you need to look at the full farmer->farm->field hierarchy when evaluating parity for a field. Once you have a field with the same enterprise ID in two or more systems, find the corresponding farm in each system, and the farmer corresponding to the farm in each system. Then, a field is only in parity when:
- The same field enterprise ID is found across systems
- The corresponding farm's farm enterprise ID is the same across these systems.
- The corresponding farmer's farmer enterprise ID is the same across these systems.
You have access to the farmer, farm, and field table data for all 3 systems as csv's (so you have a total of 9 csv's for this data).

As an example of parity, let's say I find a field with field enterprise ID of 123 in all 3 systems. Then the corresponding farm in BST and SAP has farm enterprise ID of 456, but the corresponding farm in AD has farm enterprise ID of 789. Then you already know that the AD field is not in parity. However, you still need to go up one more step in the hierarchy to check BST and SAP - so you check the corresponding farmer in BST and SAP and each has an enterprise farmer ID of 521. We see now that the field record in BST and SAP are in parity, but the AD record is not in parity. Therefore, this would add 1 to the count for the (BST=1, SAP=1, AD=0) row, but also add 1 to the count for the (BST=0, SAP=0, AD=1) row. As you can see, we are measuring field parity according to the matching of enterprise  ID's across the farm->farmer->field hierarchy.

As another example, let's say you have a field record from SAP with an enterprise ID of 987. There are no field records in BST or AD that have an enterprise ID of 987. Therefore you know that this adds 1 to the count for the (BST=0, SAP=1, AD=0) row in the table.
You do not need to check the hierarchy in this case because the field enterprise ID criteria already tells you that this SAP record is not in parity with BST and AD.

Enterprise ID's are also not always stored consistently in the 3 systems. If you come across a field record in SAP, for example, that has a null enterprise ID, then this field is not in parity, meaning this adds 1 to the count for the (BST=0, SAP=1, AD=0) row. Basically, null is never considered to be equal to null when considering parity.

The parity table should have a row with the count for each combinatorial possibility - e.g. a row for BST=1, SAP=0, AD=0, a row for BST=0, SAP=1, AD=0, a row for BST=0, SAP=0, AD=1, a row for BST=1, SAP=1, AD=0, and so on. The only combinatorial "possibility" that should not have a row is BST=0, SAP=0, and AD=0, since this is not actually possible (you will never "find" a row that is not in any of the 3 systems).

Following the rules for the parity measurement, each row in a field table should contribute to the count of exactly one row in the parity table.

This table is going to live in Snowflake, our enterprise warehouse, and we will use dbt, our enterprise pipeline tool. However, it is not necessary to do our development in Snowflake - instead we can do our development in DuckDB. You will need to install DuckDB and dbt with pip, then develop the solution locally. Use the csv's I provided as dbt seeds for your source data. Once you've developed the solution, I will deploy the solution to a production schema in Snowflake (this is a simple config change). This is where the data can be queried and the data will feed into a Venn diagram dashboard in our BI tool. You don't have to worry about building the dashboard, I just mention this aspect as context.

You should develop this solution using DuckDB and dbt with SQL models (don't use python models, it should not be necessary and all of our analysts/engineers/scientists are comfortable with SQL). You can break your problem down into intermediate models to make the solution easier to build and understand. The pipelines will likely require several steps and intermediate models are preferred over a single model with a giant CTE. dbt will track data lineage for us automatically which is another reason to use dbt. Also, you should add tests for any assumptions you are making about the data that your logic depends on - e.g. if you are assuming a certain column is a primary key (and your logic depends on that), you should add a "not_null" and "unique" test for that column. We don't want to just assume that the data is perfect, and the tests will also serve as documentation of the assumptions you are making.

Once you have built and run the pipeline and the parity table is in your local DuckDB, please export a csv of the table for me to review. 

Additionally, leadership wants a single metric that tracks "Overall Field Parity".
For this, you can again use dbt + DuckDB (same dbt project), but it will just be a table with a single cell containing the measurement value. The value should be the count for the "center" of the Venn diagram measurements, divided by all measurements (e.g. BST=1, SAP=1, AD=1 divided by all). Again export this table to a csv for me to review.

This concludes the instructions, please explore the context as needed and complete the project as described. Your work will be directly translated to a production deployment in Snowflake, so it needs to be high quality.