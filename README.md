# credit_card_acceptance

Classification Project

Instructions:

Build a model that will provide insight into why some bank customer accept credit card offers. 
Explain the data and findings.
Help the bank maximize time and money by focusing on potential customers with the highest probability of joining. 
Define which features have the biggest influence on whether the customer is going to join or not. 


Plan:

We have created a database with SQL, and explored the data.

We then uploaded the database to a Jupyter notebook. 
Checked for correlation, got rid of a few features (#bank_accounts_open, #credit_cards_held, homes_owned, household_size) had a VIF (multicolinearity value) higher than 5. We also dropped Balance, as it is a calculated field based on the Avg Quarterly Balances. We tried different models (KNN, logistic Regression, Random Forrest...) and SMOTE for oversampling in order to check which one had the best Accuracy, Kappa and Recall scores. 

We then used Tableau to visualize with graphics the imbalance in data and the possible relationships between different features,
and compared those results with our findings from Python.  

There are two Jupyter notebooks: 
- Mid_camp_lab_5.ipynb - complete analysis and model comparison.
- Mid_camp_lab_final.ipynb - final, narrowed down file with just what it's needed to run the Random Forest Classifier.

Instructions to run project:
Open mid-bootcamp-project.sql in mysql server and run the create table and import data from creditcardmarketing.csv csv file in the Data Source folder.
Once you have the data in the database, open Mid_camp_lab_final.ipynb in Jupyter notebooks and run the file.
