from databricks.connect import DatabricksSession

spark = DatabricksSession.builder.getOrCreate()