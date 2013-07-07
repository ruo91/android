/* Event */
function addEvent(obj,evt,fn){
	evt = (evt.indexOf(" ") != -1) ? evt.split(" ") : [evt];
	for(i in evt){
		var e = evt[i];
		if(e == "mousewheel"){
			if(obj.addEventListener) obj.addEventListener('DOMMouseScroll', fn, false);
			obj.onmousewheel = fn;
			break;
		}
		if(obj.addEventListener) obj.addEventListener( (e=="mousewheel") ? "DOMMouseScroll" : e,fn,false );
		else if(obj.attachEvent) obj.attachEvent('on'+e,fn);
	}
}
//<![CDATA[
// popBgLayer
function popBgLayer(){
	var activeFlag = false; 
	var contentLry = "";
	var bgLry = null;
	var root = this;
	
	setTimeout(function(){
		addEvent(window, 'resize', function(){
			root.contentLry_setPosition();
		});
		addEvent(window, 'resize', function(){
			root.bgLry_setPosition();
		});
	}, 0);

	this.selectBoxVisibility = function(status){
		if(navigator.appVersion.indexOf("MSIE 6.0") != -1){
			var slt = document.getElementsByTagName("SELECT");
			for(i=0; i<slt.length; i++)
				slt[i].style.visibility = status;
		}
	}

	this.createBgLry = function(){
		bgLry = document.createElement("div");
		var objBody = document.body || document.documentElement;
		objBody.appendChild(bgLry);
		
		bgLry.setAttribute('id', 'lry_popupBg');
		with(bgLry.style){
			display = "none";
			position = "absolute";
			top = "0";
			left = "0";
			zIndex = "100";
			backgroundColor = '#000000';
			filter = "alpha(opacity=40)";
			opacity = .4;
		}
		root.bgLry_setPosition();	
		// bgLry.onclick = function(){ root.close(); }
	}
	
	this.contentLry_setPosition = function(){
		if(!contentLry) return false;
		var winW=Number(document.documentElement.clientWidth);
		var winH=Number(document.documentElement.clientHeight);
		var scrollT=Number(document.documentElement.scrollTop || document.body.scrollTop);
		var scrollL=Number(document.documentElement.scrollLeft || document.body.scrollLeft);
		var scrollH=Number(document.documentElement.scrollHeight);

		contentLry.w = Number(contentLry.offsetWidth);
		contentLry.h = Number(contentLry.offsetHeight);
	
		if(contentLry.h > winH){
			if(contentLry.h >= scrollH){
				// 레이어가 문서의 전체 세로사이즈 보다도 클경우
				contentLry.style.top = "10px";
			}else{
				// 레이어가 브라우저의 보이는 화면높이 보다는 크지만 총 문서의 높이보다는 작을때
				var tmp = (scrollH-scrollT)-(contentLry.h+15);
				if(tmp>=0){
					contentLry.style.top = scrollT+15+"px";
				}else{
					var h = contentLry.h-(scrollH-scrollT);
					contentLry.style.top = Number(scrollT-h-15)+"px";
				}
			}
		}else{
			contentLry.style.top = Math.floor(winH/2-contentLry.h/2+scrollT) + "px";
		}
		contentLry.style.left = Math.floor(winW/2-contentLry.w/2+scrollL) + "px";
	}

	this.bgLry_setPosition = function(){
		if(!bgLry) return false;
		var w=document.documentElement.clientWidth;
		var h=document.documentElement.clientHeight;
		bgLry.style.width = w+"px";
		bgLry.style.height = h+"px";
		
		var scroll_w=document.documentElement.scrollWidth;
		var scroll_h=document.documentElement.scrollHeight;
		
		if(scroll_h>h) h=scroll_h;
		if(scroll_w>w) w=scroll_w;
		
		bgLry.style.width = w+"px";
		bgLry.style.height = h+"px";
	}

	this.run = function(target, returnCheck) {
		root.selectBoxVisibility('hidden');		
		if(!bgLry){
			root.createBgLry();
			bgLry = document.getElementById("lry_popupBg");	
		}
		
		root.bgLry_setPosition();
		bgLry.style.display = "block";
	
		var source = document.getElementById(target);
		with(source.style){
			top = "-1000em";
			left = "-1000em";
			position = "absolute";
			display = "block";
			zIndex = "1000000";
		}
		contentLry = source;
		root.contentLry_setPosition(source);
		root.bgLry_setPosition();
		
		activeFlag = true;
		if(returnCheck != "flash") return false;
	}
	
	this.close = function(){
		contentLry.style.display = 'none';
		bgLry.style.display = "none";
		root.selectBoxVisibility('visible');
		
		activeFlag = false;
		return false;
	}
}

function testAlert() {
	
}
var popBgLayer = new popBgLayer();
//]]>


function flashSet(s,w,h,d,bg,t,f,l){

	var code = "";
    code  = "<object type=\"application/x-shockwave-flash\" ";
    code +=         "data=\""+s+"\" ";
    code +=         "width=\""+w+"\" height=\""+h+"\" id=\""+d+"\">";
    code += "<param name=\"movie\" value=\""+s+"\" />";
    code += "<param name=\"quality\" value=\"high\" />";
    code += "<param name=\"wmode\" value=\""+t+"\" />";
    code += "<param name=\"menu\" value=\"false\" />";
    code += "<param name=\"allowScriptAccess\" value=\"always\" />";
    code += "<param name=\"swliveconnect\" value=\"true\" />";
	code += "<param name='scale' value='"+f+"' />";
	code += "<param name='salign' value='"+l+"' />";
    code += "</object>";

	return code;
}
function flashWrite(s,w,h,d,bg,t,f,l) {
	document.write (flashSet(s,w,h,d,bg,t,f,l));
}

// show hide
function showLy(id){
    var bx = document.getElementById(id);
    if (bx.style.display == 'block') 
        {
            bx.style.display='none';
        }
    else
        {
            bx.style.display='block';
        }
}