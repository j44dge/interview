import Foundation

//Question 1 (string calc)
//This also supports question 2
func Add( numbers: String ) -> Int 
{
   var sum: Int = 0
   
    for i in numbers.characters
    {
       if ( i != "," )
       {
           let convertToInt =  Int( String ( i ) )
           if ( convertToInt != nil ) //Check for nil just in case
           {
              sum += convertToInt! //need to force unwrap this due to down casting
           }
       }
       
    }
    
    return sum
}

//Question 3 (string calc /w custom delimiter)
func Add2( numbers: String ) -> Int 
{
   var sum: Int = 0
   var firstNewLineFound = false
   var customDelimiter: String = ""
   
    for i in numbers.characters
    {
      
       if ( !firstNewLineFound )
       {
          customDelimiter += String ( i ) 
          if ( i  == "\n" )
            { 
              firstNewLineFound = true
              //Get the character that is to the left of the new line character
              customDelimiter = String( customDelimiter.suffix( 2 ) )
            }
       }
       //At this point we have the custom delimiter 
       
       //Need to cast i to a String type for comparison to the delimiter
        if ( String ( i ) !=  customDelimiter  )
       {
           let convertToInt =  Int( String ( i ) )
           if ( convertToInt != nil ) //Check for nil just in case
           {
              sum += convertToInt! //need to force unwrap this due to down casting
           }
       }
       
    }
    
    return sum
}



//Declare exception for throwing if needed, in Question 4
enum Case4Error : Error
{
    case NegativeFound (message: String )
}



//Question 4 (Handle negative numbers)
//Handles numbers larger than 1K
func Add3( numbers: String ) throws -> Int 
{
   var sum: Int = 0
   var customDelimiter: String = ""
   var negativeFound = false
   var negativeArray: [ Int ] = []
   let intLimit = 1001
   
   let array1 = numbers.split( separator: "\n" )
  
   let strDelim = String ( array1[0] )
   let strNumbers = String ( array1[1] )
   
   //Check for delimiter
   if ( strDelim.hasPrefix( "//" )  ) 
   {
      let substr = strDelim.index(strDelim.startIndex, offsetBy: 2)..<strDelim.endIndex
      customDelimiter = String ( strDelim[ substr ] )
   }
   
   //Split up second string (containing the numbers)
   //*** This line will need to be modified for the BONUS part of having
   //delimiters of arbitrary length***
   let numbersArray = strNumbers.split( separator: Character( customDelimiter ) )
   
   
   for i in numbersArray
   {
       //convert to Int first
       let current = Int ( i )!
       
       if current < 0 
       {
           negativeFound = true
           negativeArray.append( current )
       }
       else if ( !negativeFound && current < intLimit)
       {
           sum += current    
       }
       
   }
   
   
   //Throw exception, showing the numbers that caused the exception
   if  negativeFound 
   {
      throw Case4Error.NegativeFound(message: "Exception: These negative numbers were found \(negativeArray)" )
   }
   
    return sum
}




//Tests for Question 1
print ("Tests for Question 1")
print ( Add( numbers: "1,2,5,1" ) ) //Should be 9
print ( Add( numbers: "9,3,4,9" ) ) //Should be 25
print ( Add( numbers: "1,2,3,4" ) ) //Should be 10
print ( Add( numbers: "8,3,9,1,0" ) ) //Should be 21

print ("Tests for Question 2")
//Question 2 -- Seems to handle new lines already? :)
print ( Add( numbers: "1\n,2\n,\n3\n" ) ) //Should be 6
print ( Add( numbers: "1\n,6,\n6\n,2" ) ) //Should be 15

print ("Tests for Question 3" )
print ( Add2( numbers: "//$\n1$2$3" ) ) //Should be 6
print ( Add2( numbers: "//@\n2@3@8" ) ) //Should be 13
print ( Add2( numbers: "//@\n2@3@8" ) ) //Should be 13
print ( Add2( numbers: "//*\n5*4\n*8\n*2" ) ) //Should be 19 (trying with new line character also, which should be ignored)

print ("Tests for Question 4" )
print ( try Add3( numbers: "//$\n1$2$3$5" ) ) //Should be 11
print ( try Add3( numbers: "//$\n4$5$7$-9" ) ) //Exception [-9]
print ( try Add3( numbers: "//@\n4@5@7@100@" ) ) //Should be 116
print ( try Add3( numbers: "//x\n600x1100x500x700x1000" ) ) //Should be 2800, 1100 is ignored