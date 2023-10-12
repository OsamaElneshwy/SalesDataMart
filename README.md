# Overview:
By using AdventureWorks2022 Dataset I have built a Sales Data Mart using (SQL Server Integration Services SSIS) SQL Server involves leveraging the capabilities of Integration Services (SSIS) and the Modeling of SQL Server, This Data mart offers several benefits, making them valuable components in the main purpose of data management and analytics within organizations

# Technologies:
- Visual Studio
- SQL Server Integration Services (SSIS)
- SQL Server Management Studio (SSMS)
- Excel for reporting

# Note:
This data mart is designed for online sales only.

# Project Stages
## 1- Data Source Selection:
- We began by selecting the AdventureWorks2022 database as our primary data source. This OLTP system serves as the foundation for our data mart.

## 2- Data Extraction:
- Using SQL Server Integration Services (SSIS), we extracted relevant data from the AdventureWorks2022 database. This extraction process involved identifying essential tables and fields for analysis.

## 3- Data Cleansing and Preprocessing:
- To ensure data quality and accuracy, we performed data cleansing and preprocessing tasks. This step involved handling missing values, removing duplicates, and transforming data as needed.

## 4- Star Schema Design:
- The foundation of our data mart is the star schema. We meticulously designed this schema to align with the specific analytical requirements of our project. This schema includes dimension tables describing various attributes and a central fact table containing numerical measures.

## 5- ETL Development:
- The core of our data integration process is the development of Extract, Transform, Load (ETL) processes. Leveraging SSIS and other ETL tools, we created workflows to extract data, apply transformations, and load it into the star schema.

## 6- Data Mart Population:
- We populated the data mart with cleansed and transformed data, ensuring that it is readily available for analysis.
These stages represent the key milestones in our journey to create a Sales Data Mart using SSIS and SQL Server. The resulting star schema empowers my mindset with an efficient view of data access and valuable insights for informed decision-making.

# Project Workflow:
## Star Schema Design:
Meticulously crafted a star schema that forms the backbone of our data mart. This star schema comprises four dimension tables—Product, Customer, Territory, and Date—and a central fact table housing our key measures and surrogate keys from the dimension tables. This design provides a solid foundation for efficient data analysis and reporting, ensuring that our data mart is well-structured and optimized for our specific analytical needs.

<img width="1280" alt="StarSchema" src="https://github.com/OsamaElneshwy/SalesDataMart/assets/36084719/0e65a041-5578-4b5c-92fa-bcde04afb960">

<img width="237" alt="ProjectOverAll" src="https://github.com/OsamaElneshwy/SalesDataMart/assets/36084719/84d78a85-52d2-4c76-88af-b57a6890b013">

<img width="1280" alt="CustomerDim" src="https://github.com/OsamaElneshwy/SalesDataMart/assets/36084719/0443cce1-cb89-4444-b344-6d5e23756ea5">

<img width="1280" alt="ProductDim" src="https://github.com/OsamaElneshwy/SalesDataMart/assets/36084719/33eb793f-43b6-47de-a9b0-1226da306fe8">

<img width="1280" alt="TerritoryDim" src="https://github.com/OsamaElneshwy/SalesDataMart/assets/36084719/06324ac5-d36d-4bef-83f5-78f9bad7a681">

<img width="1280" alt="DateDim" src="https://github.com/OsamaElneshwy/SalesDataMart/assets/36084719/3d10a26e-907a-41cb-b0d6-0eb1cf142f53">

<img width="1280" alt="FullLoadSalesFact2" src="https://github.com/OsamaElneshwy/SalesDataMart/assets/36084719/f537daea-20a1-4e4d-aaa0-77a560e9ac76">

<img width="1280" alt="IncrementalSalesFact2" src="https://github.com/OsamaElneshwy/SalesDataMart/assets/36084719/b4fe897b-37c1-47dd-b644-ac6cf8949e19">

<img width="1280" alt="CubeBrowers" src="https://github.com/OsamaElneshwy/SalesDataMart/assets/36084719/a0a7b457-48a9-46a7-b381-e0d054c5fc55">

<img width="1280" alt="ExeclAnalysis" src="https://github.com/OsamaElneshwy/SalesDataMart/assets/36084719/7967c555-2beb-4c51-889a-4adb0b9d7862">












