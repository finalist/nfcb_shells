var sheets = "";

sheets = '<LINK rel="stylesheet" type="text/css" href="http://portal.hhs.nl/images/hhs/Library/Stylesheets/main.css" media="all">' + "\r";

// document.write(sheets);

function replace(strGeheleString, strVervangDit, strVervangMet) {
  var strResult = "";
  while(strGeheleString.indexOf(strVervangDit) != -1) {
    if (strGeheleString.indexOf(strVervangDit) > 0) {
      strResult = strResult + strGeheleString.substring(0, strGeheleString.indexOf(strVervangDit)) + strVervangMet;
    }
    else {
      strResult = strResult + strVervangMet;
    }
    strGeheleString = strGeheleString.substring(trGeheleString.indexOf(strVervangDit) + strVervangDit.length, strGeheleString.length);     
  }
  return strResult + strGeheleString;
} 

function printPage() {
  var newWindow = null;
  var newBody   = null;      
  newBody = new String(this.document.getElementsByTagName("body").item(0).innerHTML);  
  newBody = newBody.slice(newBody.indexOf("<!-- Start content -->"), newBody.indexOf("<!-- End content -->"));
  newBody = newBody.substring(newBody.toLowerCase().indexOf('</table>') + 8, newBody.toLowerCase().lastIndexOf('</table>') + 8 );
  newBody = replace(newBody, '/oracle_smp_chronos/oracle_smp_chronos.js', '');
  if (newWindow == null) {
    newWindow = window.open('', 'Title', 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,copyhistory=0,width=750,height=600');
  }
  newWindow.document.open();
  newWindow.document.writeln('<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">');
  newWindow.document.writeln('<HTML><HEAD>');
  newWindow.document.writeln( sheets );    
  newWindow.document.writeln('<TITLE>Printversie</TITLE>');
  newWindow.document.writeln('</HEAD><BODY onLoad="window.print()">');
  newWindow.document.writeln('<DIV style="width: 95%;">');
  if (newBody != null) { newWindow.document.writeln(newBody); }
	 newWindow.document.writeln('</DIV>');
  newWindow.document.writeln('</BODY></HTML>');
  newWindow.document.close();
  newWindow.focus();
}


function MM_openBrWindow(theURL,winName,features) {
  window.open(theURL,winName,features);
}
