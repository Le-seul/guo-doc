String Number(int num){

  if(num>=1000){
    return '${num~/1000}k+';
  }else if(num>=100){
    return '${num~/100}00+';
  }else {
    return '$num';
  }

}