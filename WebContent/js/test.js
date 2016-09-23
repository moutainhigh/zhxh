/**
 * 
 */

var Cat = {
	createNew: function(obj){
		var cat = {};
		var obj = obj;
		var sound = "喵喵喵";
		var url = "";
		var columns = [];
		cat.makeSound = function(){
			return sound; 
		};
		cat.getUrl = function(){
			return url;
		};
		cat.load = function(par){
			return obj;
		};
		cat.set = function(v) {
			url = v.url;
			columns = v.columns;
		};
		return cat;
	}
};

//var ussoft = window.NameSpace || {};
//ussoft = new function() {
//	var self = this;
//	var name = 'world';
//	var obj;
//	var url = "";
//	var columns = [];
//	self.sayHello = function(_name) {
//		return 'Hello ' + (_name || name);
//	};
//	
//	self.get = function(_obj) {
//		obj = $("#"+_obj);
//		obj.set = function(set) {
//			url = set.url;
//			columns = set.columns;
//		}
//		alert(obj.url);
//		return obj;
//	}
//};

//(function() {
//	//向window注册命名空间IC。      
//    window['IC']={}  
//          
//        function $()  
//        {  
//                //定义元素数组,数组对象。  
//                var elements=new Array();  
//                //对数组进行循环验证。arguments是js的一个内部对象返回，返回function传递的参数对象，数组形式。  
//                for(var i=0;i<arguments.length;i++)  
//                {  
//                    //定义element对象，把参数数组读出来。  
//                    var element=arguments[i];  
//                    //判断数组中的原元素是否是字符串类型。  
//                    if(typeof element=='string')  
//                    {  
//                        element=document.getElementById(element);  
//                    }  
//                    //判断当前的参数知否只有一个，我们就直接返回这个参数。  
//                    if(arguments.length==1)  
//                    {  
//                        return element;  
//                    }  
//                    //如果多个参数的话。我们放入数组elements中。  
//                    elements.push(element);  
//                }  
//                    //把所有的全取出来并返回。  
//                    return elements;  
//            }  
//        //向windows上注册命名空间IC，并向命名空间中注册$方法。  
//        window['IC']['$']=$;  
//})();  
