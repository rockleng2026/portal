    function isIdCardNo(num) 
    { 
        var factorArr = new Array(7,9,10,5,8,4,2,1,6,3,7,9,10,5,8,4,2,1); 
        var error; 
        var varArray = new Array(); 
        var intValue; 
        var lngProduct = 0; 
        var intCheckDigit; 
        var intStrLen = num.length; 
        var idNumber = num; 
        // initialize 
        if ((intStrLen != 15) && (intStrLen != 18)) 
        { 
            return false; 
        } 
        // check and set value 
        for(i=0;i<intStrLen;i++) 
        { 
            varArray[i] = idNumber.charAt(i); 
            if ((varArray[i] < '0' || varArray[i] > '9') && (i != 17)) 
            { 
                return false; 
            } 
            else if (i < 17) 
            { 
                varArray[i] = varArray[i]*factorArr[i]; 
            } 
        } 
        
        if (intStrLen == 18) 
        { 
            //check date 
            var date8 = idNumber.substring(6,14); 
            if (checkDate(date8) == false) 
            { 
                //error = "身份证中日期信息不正确！."; 
                return false; 
            } 
            // calculate the sum of the products 
            for(i=0;i<17;i++) 
            { 
                lngProduct = lngProduct + varArray[i]; 
            } 
            // calculate the check digit 
            intCheckDigit = 12 - lngProduct % 11; 
            switch (intCheckDigit) 
            { 
                case 10: 
                intCheckDigit = 'X'; 
                break; 
                case 11: 
                intCheckDigit = 0; 
                break; 
                case 12: 
                intCheckDigit = 1; 
                break; 
            } 
            // check last digit 
            if (varArray[17].toUpperCase() != intCheckDigit) 
            { 
                return false; 
            } 
       } 
       else
        {   //length is 15 
            //check date 
            var date6 = idNumber.substring(6,12); 
            if (checkDate(date6) == false) 
            { 
                //alert("身份证日期信息有误！."); 
                return false; 
            } 
        } 
        return true; 
    } 
    
    function checkDate(date) 
    { 
        return true; 
    } 

    function test()
    {
        var id = document.getElementById('id').value;
        alert(id);
        alert(isIdCardNo(id));
    }