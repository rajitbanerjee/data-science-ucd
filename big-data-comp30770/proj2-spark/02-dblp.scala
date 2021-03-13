import org.apache.spark._
import org.apache.spark.rdd.RDD
import org.apache.spark.graphx._
import org.apache.spark.graphx.util.GraphGenerators
import org.apache.spark.graphx.lib.ShortestPaths
import org.apache.log4j._

Logger.getLogger("org").setLevel(Level.ERROR)

// q1. build co-authorship graph
println("\nBuilding co-authorship graph...")

// parse co-authorship edge list into coauthorsRDD
case class CoAuthors(author1: String, author2: String)
def parseAuthors(line: String): CoAuthors = {
  val authors =  line.split(",")
  CoAuthors(authors(0), authors(1))
}
var textRDD = sc.textFile("./data/dblp_coauthorship.csv")
val header = textRDD.first()
textRDD = textRDD.filter(row => row != header)
val coauthorsRDD = textRDD.map(parseAuthors).cache()


// extract author nodes (for Vertex RDD) and assign IDs; create map from name to ID numbers
val authors = coauthorsRDD.map(pair => pair.author1).distinct.zipWithIndex.map(a => (a._2, a._1))
val authorIdMap = authors.map {case (id, name) => (name -> id)}.collect.toMap

// prepare Edge RDD required for graph
val idPairs = coauthorsRDD.map(pair => (authorIdMap(pair.author1), authorIdMap(pair.author2)))
val edges = idPairs.map {
  case (auth1_id, auth2_id) => Edge(auth1_id, auth2_id, "1")
}

// set default vertex and create graph
val default = "default"
val graph = Graph(authors, edges, default)

println("Done!\n")
println("Number of authors (vertices): " + graph.numVertices)
println("Number of co-authorships (edges): " + graph.numEdges)

println("\nSample vertices:")
graph.vertices.take(3).foreach(println)

println("\nSample edges:")
graph.edges.take(3).foreach(println)


// q2. shortest paths
val erdos = authorIdMap("Paul Erdös")
val paths = ShortestPaths.run(graph, Seq(erdos)).vertices

// each vertex is the ID of an author and a map with distance to erdos;
// sort in descending order of distance to erdos, then take the top distance
val sortedPaths = paths.sortBy(_._2.get(erdos), ascending=false)
val maxErdos = sortedPaths.take(1)(0)._2.get(erdos).get

println("\nMaximum Erdös number of authors in the dataset: " + maxErdos + "\n\n")

// note: comment out line below if you wish to stay in the spark shell
System.exit(0)
