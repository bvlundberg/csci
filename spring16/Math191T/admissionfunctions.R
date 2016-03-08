gpaadmit <- function(gpa){
  return (-4.3576 + (gpa*1.0511))
}

admitvalue <- function(gpa, gre, rank){
  return ((-3.4495) + (.777014*gpa) + (.002294*gre) - (.560031*rank))
}

newadmitvalue <- function(gpa, gre, rank){
  val = 0
  if(rank == 1){
    val = ((-5.541) + (.00226*gre) + (.804038*gpa) + (1.551*rank))
    return (val > 0)
  }
  if(rank == 2){
    val = ((-5.541) + (.00226*gre) + (.804038*gpa) + (.876*rank))
    return (val > 0)
  }
  if(rank == 3){
    val = ((-5.541) + (.00226*gre) + (.804038*gpa) + (.211*rank))
    return (val > 0)
  }
  if(rank == 4){
    val = ((-5.541) + (.00226*gre) + (.804038*gpa))
    return (val > 0)
  }
  
}