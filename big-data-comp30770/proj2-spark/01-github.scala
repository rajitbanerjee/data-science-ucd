// load dataset and create SQL table
val github = spark.read.format("com.databricks.spark.csv").
  option("header", "true").
  option("inferSchema","true").
  load("./data/github-big-data.csv")

github.registerTempTable("github")


// q1. determine which project has the most stars
println("\n1. Which project has the most stars?")
val mostStars = spark.sql("""
  SELECT * FROM github 
  WHERE stars=(SELECT MAX(stars) FROM github);
  """)
mostStars.show()


// q2. compute the total number of stars for each language
println("2. How many stars does each language have?")
val starsByLang = spark.sql("""
  SELECT language, SUM(stars) 
  FROM github 
  GROUP BY language
  ORDER BY SUM(stars) DESC;
  """)
starsByLang.show()


// q3a. determine the number of project descriptions that contain the word “data”.
// note: also matches substrings + case insensitive
println("3a. How many project descriptions contain the word 'data'?")
val countWordData = spark.sql("""
  SELECT COUNT(*)
  FROM github 
  WHERE LOWER(description) LIKE '%data%';
  """)
countWordData.collect.foreach(println)


// q3b. among those, how many have their language value set (not empty/null)?
println("\n3b. Among those, how many have their language value set (not empty/null)?")
val countDataWithLang = spark.sql("""
  SELECT COUNT(*) 
  FROM github 
  WHERE LOWER(description) LIKE '%data%' AND language <> '';
  """)
countDataWithLang.collect.foreach(println)


// q4. determine the most frequently used word in project descriptions
println("\n4. What is the most frequently used word in the project descriptions?")
val descriptions = spark.sql("SELECT description FROM github")
val words = descriptions.explode("description", "word")((line: String) => line.split(" "))
words.groupBy("word").count().orderBy(desc("count")).collect.take(1).foreach(println)

// note: comment out line below if you wish to stay in the spark shell
System.exit(0)
