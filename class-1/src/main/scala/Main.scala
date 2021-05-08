import javafx.concurrent.Worker

import scala.annotation.tailrec
import scala.util.{Failure, Success, Try}

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

    class2Exercise1(daysOfWeek)
    class2Exercise2()
    class2Exercise3()
    class2Exercise4()
    class2Exercise5()
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

    def applySale(products: Map[String, Double]) = products.mapValues(_ * 0.9).toMap

    println(s"Old products: $products")
    println(s"New products: ${applySale(products)}")
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

  def class2Exercise1(days: List[String]): Unit = {
    def toKindOfDayString(day: String): String = {
      val workDay = "Praca"
      val offDay = "Weekend"
      val unknownDay = "Nie ma taiego dnia"
      day match {
        case "Poniedziałek" => workDay
        case "Wtorek" => workDay
        case "Sroda" => workDay
        case "Czwartek" => workDay
        case "Piątek" => workDay
        case "Sobota" => offDay
        case "Niedziela" => offDay
        case _ => unknownDay
      }
    }

    println(s"days.map(toKindOfDayString): ${days.map(toKindOfDayString)}")
  }

  def class2Exercise2(): Unit = {
    class BankAccount() {

      private var _balance: Double = 0

      def this(balance: Double) {
        this()
        _balance = balance
      }

      def balance: Double = _balance

      def deposit(amount: Double): Unit = {
        println(s"Depositing $amount into account. Balance before: ${_balance}")
        _balance += amount
        println(s"Balance after: ${_balance}")
      }

      def withdraw(amount: Double): Unit = if (_balance < amount) println("Withdraw amount is greater then balance.") else {
        println(s"Withdrawing $amount from account. Balance before: ${_balance}")
        _balance -= amount
        println(s"Balance after: ${_balance}")
      }
    }

    println(s"Account1")
    val account = new BankAccount(1000)
    account.withdraw(500)
    account.deposit(500)

    println(s"Account2")
    val account2 = new BankAccount()
    account2.withdraw(500)
    account2.deposit(500)
    account2.withdraw(500)
  }

  def class2Exercise3(): Unit = {
    case class Person(name: String, surname: String)

    def customGreet(person: Person): Unit = {
      person match {
        case Person("John", "Doe") => println("Hello John, I suppose you do not have an id on you")
        case Person("Jane", "Doe") => println("Hello Jane, it is a shame that you do not know you real name")
        case Person("Jane", _) => println("Hello Jane, I hope your surname is other then Doe. Is it?")
        case Person(name, surname) => println(s"Hello $name $surname, nice to meet you")
        case _ => println("You are not human")
      }
    }

    val person1 = Person("John", "Doe")
    val person2 = Person("Jane", "Doe")
    val person3 = Person("Jane", "Boe")
    val person4 = Person("Micheal", "Jackson")

    customGreet(person1)
    customGreet(person2)
    customGreet(person3)
    customGreet(person4)
  }

  def class2Exercise4(): Unit = {
    def mapIntSafe(value: Int, operation: Int => Int) = {
      Try(value)
        .map(operation)
        .map(operation)
        .map(operation)
      match {
        case Success(value) => value
        case Failure(e) => e.printStackTrace(); value
      }
    }

    def add1(value: Int) = value + 1

    def divide0(value: Int) = value / 0

    println(s"mapInt(10, add1): ${mapIntSafe(10, add1)}")
    println(s"mapInt(10, divide0): ${mapIntSafe(10, divide0)}")
  }

  def class2Exercise5(): Unit = {
    abstract class Person(val name: String, val surname: String) {
      def tax: Double

      override def toString: String = s"name: $name, surname: $surname, tax: $tax"
    }
    trait Student extends Person {
      override def tax: Double = 0
    }
    trait Worker extends Person {
      var _salary: Double = 0

      override def tax: Double = this._salary * 0.2

      def getSalary: Double = this._salary

      def setSalary(value: Double): Unit = this._salary = value

      override def toString: String = s"name: $name, surname: $surname, tax: $tax, salary: ${_salary}"
    }
    trait Tutor extends Worker {
      override def tax: Double = this._salary * 0.1
    }

    val student = new Person("Jan", "Kowalski") with Student
    val worker = new Person("Andrzej", "Pracowity") with Worker
    val tutor = new Person("Robert", "Magister") with Tutor
    val studentWorker = new Person("Dżony", "Kesz") with Student with Worker
    val workerStudent = new Person("Kesz", "Dżony") with Worker with Student

    worker.setSalary(2000)
    tutor.setSalary(2000)
    studentWorker.setSalary(2000)
    workerStudent.setSalary(2000)

    println(s"student: $student")
    println(s"worker: $worker")
    println(s"tutor: $tutor")
    println(s"studentWorker: $studentWorker")
    println(s"workerStudent: $workerStudent")
  }
}