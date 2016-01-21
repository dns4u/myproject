function onlyAlphabets(e, t) {
  try
    {
      if (window.event) 
        {
          var charCode = window.event.keyCode;
        }
      else if (e)
        {
          var charCode = e.which;
        }
      else { return true; }
        if ((charCode > 64 && charCode < 91) || (charCode > 96 && charCode < 123)||charCode <31)
          return true;
        else
          alert("Please, enter alphabets only");
        return false;
    }
  catch (err) 
    {
      alert(err.Description);
    }
  }

function onlyNumber(e, t) {
  try
    {
      if (window.event) 
        {
          var charCode = window.event.keyCode;
        }
      else if (e)
        {
          var charCode = e.which;
        }
      else { return true; }
        if ((charCode > 47 && charCode < 58)||charCode <31)
          return true;
        else
          alert("Please, enter number only");
        return false;
    }
  catch (err) 
    {
      alert(err.Description);
    }
  }

function required()  
  {  
    var firstname=document.getElementById("firstname").value;
    var lastname=document.getElementById("lastname").value;
    var gender=document.getElementById("gender").value;
    var mobilenumber=document.getElementById("mobilenumber").value;
    var email=document.getElementById("email").value;
    var password=document.getElementById("password").value;
    var confirmpassword=document.getElementById("confirmpassword").value;
    var position=document.getElementById("position").value;
    if (firstname == "" || lastname == "" || gender == "Select Gender" || address == "" || mobilenumber == "" || email == "" || password == "" || confirmpassword == "" || position == "" )  
      {  
        alert("Please, fill all fields.");  
        return false;  
      }
    if (password == confirmpassword)
    {
      return true;
    } 
    else
      alert("Password doesn't match");
    return false;
    }  

    function groupRequired()  
  {  
    var gname=document.getElementById("gname").value;
    var gpassword=document.getElementById("gpassword").value;
    var gcpassword=document.getElementById("gcpassword").value;
    var aname=document.getElementById("aname").value;
    
    if (gname == "" || gpassword == "" || gcpassword == "" || aname == "")  
      {  
        alert("Please, fill all fields.");  
        return false;  
      }
    if (gpassword == gcpassword)
    {
      return true;
    } 
    else
      alert("Password doesn't match");
    return false;
    }  
function require()  
  {  
    var search=document.getElementById("file_search").value;
    if(search == "")
    {
      return false;
    }
    else
      return true;
  }
  function userLength()
  {
    var user=document.getElementById("email").value;
    if(user.length <5)
    {
      document.getElementById("email").focus();
      alert("User Name must contain  at least 5 character ");
      
      return false;
    }
    else
      return true;
  }

  function passwordLength()
  {
    var user=document.getElementById("password").value;
    if(user.length <6)
    {
      document.getElementById("password").focus();
      alert("Password must contain  at least 6 character ");
      
      return false;
    }
    else
      return true;
  }

   function gpasswordLength()
  {
    var user=document.getElementById("gpassword").value;
    if(user.length <6)
    {
      document.getElementById("gpassword").focus();
      alert("Password must contain at least 6 character ");
      
      return false;
    }
    else
      return true;
  }

   function groupLength()
  {
    var user=document.getElementById("gname").value;
    if(user.length <3)
    {
      document.getElementById("gname").focus();
      alert("Group name must contain  at least 3 character ");
      
      return false;
    }
    else
      return true;
  }
  
