import scala.annotation.tailrec

object Main {
  def main(args: Array[String]) = {
    //  val daysOfWeek = List("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday")
    val daysOfWeek = List("Poniedziałek", "Wtorek", "Sroda", "Czwartek", "Piątek", "Sobota", "Niedziela")

    exercise1(daysOfWeek)
    exercise2(daysOfWeek)
    exercise3(daysOfWeek)
    exercise4(daysOfWeek)
    exercise5()
    exercise6()
    exercise7()
    exercise8()
    exercise9()
    exercise10()
  }

  def exercise1(days: List[String]): Unit = {
    println(concatenate1(days))
    println(concatenate2(days))
    println(concatenate3(days))

    def concatenate1(days: List[String]) = {
      var concatenatedDays = ""
      for (i <- days.indices) {
        concatenatedDays += initiateOrAppend(days, concatenatedDays, i)
      }
      concatenatedDays
    }

    def concatenate2(days: List[String]) = {
      val daysStartingWithP = days.filter(_.startsWith("P"))
      concatenate1(daysStartingWithP)
    }

    def initiateOrAppend(days: List[String], concatenatedDays: String, i: Int): String = {
      if (i == 0) {
        days.head
      } else {
        s",${days(i)}"
      }
    }

    def concatenate3(days: List[String]) = {
      var concatenatedDays = ""
      var i = 0
      while (i != days.length) {
        concatenatedDays += initiateOrAppend(days, concatenatedDays, i)
        i += 1
      }
      concatenatedDays
    }
  }

  def exercise2(days: List[String]): Unit = {
    def concatenateRecursive(days: List[String]): String = days match {
      case Nil => ""
      case day :: Nil => day
      case day :: tail => s"$day,${concatenateRecursive(tail)}"
    }

    def concatenateRecursiveReverse(days: List[String]): String = days match {
      case Nil => ""
      case day :: Nil => day
      case day :: tail => s"${concatenateRecursiveReverse(tail)},$day"
    }

    println(concatenateRecursive(days))
    println(concatenateRecursiveReverse(days))
  }

  def exercise3(days: List[String]): Unit = {
    def concatenateRecursiveTailRec(days: List[String]): String = {
      @tailrec
      def concat(d: List[String], accum: String): String = d match {
        case Nil => accum
        case day :: tail => concat(tail, s"$accum,$day")
      }

      concat(days, "")
    }

    println(s"Tailrec: ${concatenateRecursiveTailRec(days)}")
  }

  def exercise4(days: List[String]): Unit = {
    def concatenateFoldLeft(days: List[String]): String = {
      days.foldLeft("")((a: String, b: String) => if (a.isEmpty) b else a + s",$b")
    }

    def concatenateFoldRight(days: List[String]): String = {
      days.foldLeft("")((a: String, b: String) => if (b.isEmpty) a else b + s",$a")
    }

    def concatenateStartingWithP(days: List[String]): String = {
      val filtered = days.filter(_.startsWith("P"))
      concatenateFoldLeft(filtered)
    }

    println(concatenateFoldLeft(days))
    println(concatenateFoldRight(days))
    println(concatenateStartingWithP(days))
  }

  def exercise5(): Unit = {
    val products = Map(
      "milk" -> 9.99,
      "bread" -> 5.49,
      "cheese" -> 2.99
    )

    def applyPromotion(products: Map[String, Double]) = products.mapValues(_ * 0.9).toMap

    println(s"Old products: $products")
    println(s"New products: ${applyPromotion(products)}")
  }

  def exercise6(): Unit = {
    val triple = ("test", 1, 2.99)

    def printTriple(triple: (String, Int, Double)): String = s"${triple._1},${triple._2},${triple._3}"

    println(printTriple(triple))
  }

  def exercise7(): Unit = {
    implicit val workers: Map[String, String] = Map(
      "Peter" -> "Developer",
      "Robert" -> "Developer",
      "Conrad" -> "Lead",
      "Matthew" -> "PO"
    )

    def getWorkerJob(name: String)(implicit workers: Map[String, String]) = workers.getOrElse(name, "No worker with that name")

    println("Job for Peter: " + getWorkerJob("Peter"))
    println("Job for Cassandra: " + getWorkerJob("Cassandra"))
  }

  def exercise8(): Unit = {
    def removeZeros(values: List[Int]): List[Int] = values match {
      case Nil => values
      case head :: tail if head == 0 => removeZeros(tail)
      case head :: tail => head :: removeZeros(tail)
    }

    println("Remove zoros = removeZeros(List(0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9)): " + removeZeros(List(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9)))
  }

  def exercise9(): Unit = {
    def addToEach(values: List[Int]): List[Int] = values.map(_ + 1)

    println("addToEach(List(0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9)): " + addToEach(List(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9)))
  }

  def exercise10(): Unit = {
    def absWithFilter(values: List[Double]): List[Double] = values.collect {
      case value: Double if value >= -5 && value <= 12 => value.abs
    }

    println(s"absWithFilter(1.2, -10, -9.1, -5, 12, 14.5): ${absWithFilter(List(1.2, -10, -9.1, -5, 12, 14.5))}")
  }
}