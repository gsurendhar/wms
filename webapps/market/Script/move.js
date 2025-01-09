function ClearList(OptionList, TitleName) 
	    {   OptionList.length = 0; 
			}
	
		//public boolean flag = false;
	
	    function move(source,dest)
		{   
			var temp1value = new Array();
			var temp1text =new Array();
		    var temp2text = new Array();
		    var temp2value = new Array();
		    var current1 = 0;
			var current2 = 0;
		    var attribute;
			var flag = false;
			//fill an array with old values
			for(var i=0;i<dest.length;i++)
			{
				
				temp1text[current1]=dest.options[i].text;
				temp1value[current1]=dest.options[i].value;
				current1++;
				
			}
			for (var i=0;i<source.length ;i++ )
			{
			
				
				if(source.options[i].selected)
				{
					temp1text[current1]=source.options[i].text;
					temp1value[current1]=source.options[i].value;
						current1++;
				}
				else
				{
					temp2text[current2]=source.options[i].text;
					temp2value[current2]=source.options[i].value;
					current2++;
				}
				
			}
			//generating new options 
            for (var i = 0; i < temp1value.length; i++)
		    {  
			dest.options[i] = new Option();
		        dest.options[i].value = temp1value[i];
		        dest.options[i].text =  temp1text[i];
				dest.options[i].selected=true;
		    }
			
			//generating new options
			ClearList(source,source);
			if (temp2value.length>0)
			{	
			    for (var i = 0; i < temp2value.length; i++)
			    {   
					source.options[i] = new Option();
			        source.options[i].value = temp2value[i];
			        source.options[i].text =  temp2text[i];
			    }
			}
		}