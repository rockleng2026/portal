


function addProElement() 
{
      var table1 = document.getElementById('bill');
      var proStart=document.getElementById("ProCount");
      var maxNO=proStart.value;
      var item1=document.getElementById('item1');
      
      var endidx=table1.rows.length;
      var newtr =table1.insertRow(endidx);
      
      newtr.id="pro"+maxNO;
      proStart.value=parseInt(maxNO)+1;
      
      
       newtd=getTD();
      newtd.innerHTML='<input name="types" id="types'+maxNO+'" type="hidden" value="" /><input name="type" id="type'+maxNO+'" readonly="readonly" type="text" onclick="return showWind('+maxNO+');"/>';
      newtr.appendChild(newtd);
      
       newtd=getTD();
      newtd.innerHTML='<input name="models" id="models'+maxNO+'" type="hidden" value=""  /><input name="model" id="model'+maxNO+'" readonly="readonly" type="text"  />';
      newtr.appendChild(newtd);
      
       newtd=getTD();
      newtd.innerHTML='<input type="text" name="num" />';
      newtr.appendChild(newtd);
       
      
      newtd=getTD2();
      newtd.innerHTML='<a href="javascript:CancelTr(\''+newtr.id+'\')">É¾³ý</a>';
      newtr.appendChild(newtd);
      
      
      
 }















































